//
//  FavouritesViewController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 19.11.2024.
//

import UIKit


struct MyEvent {
    let date: String
    let title: String
    let place: String
}


// MARK: - Protocol for View Input
protocol FavouritesViewInput: AnyObject {
    func updateEvents(_ events: [MyEvent])
    func showNoBookmarksMessage()
    func hideNoBookmarksMessage()
    func onSearchTapped()
}

class FavouritesViewController: UIViewController {

    // MARK: - Properties
    var viewOutput: FavouritesViewOutput!
    private var eventsArray: [MyEvent] = []

    // MARK: - Views
    private var collectionView: UICollectionView!

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tintColor = AppColors.black
        label.text = "Favorites"
        label.font = .airbnbFont(ofSize: 26, weight: .book)
        return label
    }()

    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "magnifying-glass")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let noBookmarksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.tintColor = .systemGray6
        label.text = "You haven't saved any articles yet. Start reading and bookmarking them now."
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.isHidden = true
        return label
    }()

    // MARK: - Initializer
    init(viewOutput: FavouritesViewOutput) {
        super.init(nibName: nil, bundle: nil)
        self.viewOutput = viewOutput
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setCollectionView()
        setConstraints()
        viewOutput.loadEvents()
        
        // Fix data loading
        eventsArray = [
                MyEvent(date: "11 November", title: "The Big Bang Theory", place: "Moscow"),
                MyEvent(date: "12 November", title: "Event Horizon", place: "Saint Petersburg"),
                MyEvent(date: "13 November", title: "Cosmic Journey", place: "Novosibirsk")
        ]
    }
}

// MARK: - FavouritesViewInput Implementation
extension FavouritesViewController: FavouritesViewInput {
    func updateEvents(_ events: [MyEvent]) {
        eventsArray = events
        collectionView.reloadData()
    }

    func showNoBookmarksMessage() {
        noBookmarksLabel.isHidden = false
        collectionView.isHidden = true
    }

    func hideNoBookmarksMessage() {
        noBookmarksLabel.isHidden = true
        collectionView.isHidden = false
    }

    func onSearchTapped() {
        print("Search tapped")
    }
}

// MARK: - Private Methods
private extension FavouritesViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(searchImageView)
        view.addSubview(noBookmarksLabel)
    }

    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            searchImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            searchImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            searchImageView.widthAnchor.constraint(equalToConstant: 33),
            searchImageView.heightAnchor.constraint(equalToConstant: 33),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            noBookmarksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noBookmarksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noBookmarksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavouriteCell
        cell.configure(with: eventsArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40
        let availableWidth = collectionView.frame.width - padding
        let cellWidth = availableWidth
        return CGSize(width: cellWidth, height: 112)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let event = eventsArray[indexPath.row]
//        let articleViewController = ArticleViewController(with: article)
//        articleViewController.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(articleViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 20
    }
}

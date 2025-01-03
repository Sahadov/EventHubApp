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
    func updateEvents(_ events: [FavouriteEvent])
    func showNoBookmarksMessage()
    func hideNoBookmarksMessage()
    func onSearchTapped()
}

class FavouritesViewController: UIViewController, FavouriteCellDelegate {

    // MARK: - Properties
    var event: FavouriteEvent?
    var viewOutput: FavouritesViewOutput!
    private var eventsArray: [FavouriteEvent] = []

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

    private let noBookmarksImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bookmark-4")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.isHidden = false
        return image
    }()
    
    private let noBookmarksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = AppColors.red
        label.text = "Ooopsss... You don't have favourite events"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.isHidden = false
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let fetchedData = CoreDataManager.shared.fetchFavouriteEvents() else { return }
//        eventsArray = fetchedData
//        collectionView.reloadData()
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setCollectionView()
        setConstraints()
        viewOutput.loadEvents()
    }
    
    func didTapBookmarkButton(id: Int64) {
        // Delete from CoreData
        guard let updatedEvent = CoreDataManager.shared.fetchFavouriteEvent(withId: id) else { return }
        CoreDataManager.shared.deleteFavouriteEvent(event: updatedEvent)

        NotificationCenter.default.post(name: Notification.Name("isFavoriteChanged"), object: nil)

        // Reload data
        reloadData()
    }
    
}

// MARK: - FavouritesViewInput Implementation
extension FavouritesViewController: FavouritesViewInput {
    func updateEvents(_ events: [FavouriteEvent]) {
        eventsArray = events
        collectionView.reloadData()
    }

    func showNoBookmarksMessage() {
        noBookmarksLabel.isHidden = false
        noBookmarksImage.isHidden = false
        
    }

    func hideNoBookmarksMessage() {
        noBookmarksLabel.isHidden = true
        noBookmarksImage.isHidden = true
        
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
        view.addSubview(noBookmarksImage)
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
    
    func reloadData(){
        guard let fetchedData = CoreDataManager.shared.fetchFavouriteEvents() else { return }
        eventsArray = fetchedData
        collectionView.reloadData()
        
        if eventsArray.count != 0 {
            hideNoBookmarksMessage()
        } else {
            showNoBookmarksMessage()
        }
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

            noBookmarksImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noBookmarksImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noBookmarksImage.widthAnchor.constraint(equalToConstant: 150),
            noBookmarksImage.heightAnchor.constraint(equalToConstant: 150),
            
            noBookmarksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noBookmarksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            noBookmarksLabel.bottomAnchor.constraint(equalTo: noBookmarksImage.topAnchor, constant: -30)
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
        cell.delegate = self
        event = eventsArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40
        let availableWidth = collectionView.frame.width - padding
        let cellWidth = availableWidth
        return CGSize(width: cellWidth, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEvent = eventsArray[indexPath.row]
        let favouritesDetailedScreen = FavouritesDetailedScreen(event: selectedEvent)
        present(favouritesDetailedScreen, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 20
    }
}

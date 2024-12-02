//
//  EventsViewController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 02.12.2024.
//

import UIKit


class EventsViewController: UIViewController {

    // MARK: - Properties
    private var eventsArray: [EventModel] = []
    private let apiManager = APIManager.shared

    // MARK: - Views
    private var collectionView: UICollectionView!

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tintColor = AppColors.black
        label.text = "Events"
        label.font = .airbnbFont(ofSize: 26, weight: .book)
        return label
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
    init() {
        super.init(nibName: nil, bundle: nil)
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
        fetchUpcomingEvents()
        print(eventsArray.count)
    }
    
    func fetchUpcomingEvents() {
        apiManager.getUpcomingEnvents(lang: "en") { [weak self] result in
            switch result {
            case .success(let events):
                DispatchQueue.main.async {
                    guard let results = events.results else { return }
                    self?.eventsArray = results
                    //self?.updateUI()
                }
            case .failure(let error):
                print("Failed to fetch upcoming events: \(error.localizedDescription)")
            }
        }
    }
    
}

// MARK: - Private Methods
private extension EventsViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
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
        eventsArray = []
        collectionView.reloadData()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

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
extension EventsViewController:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UpcomingEventCell
        cell.configure(with: eventsArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40
        let availableWidth = collectionView.frame.width - padding
        let cellWidth = availableWidth
        return CGSize(width: cellWidth, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedEvent = eventsArray[indexPath.row]
//        let favouritesDetailedScreen = FavouritesDetailedScreen(event: selectedEvent)
//        present(favouritesDetailedScreen, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 20
    }
}



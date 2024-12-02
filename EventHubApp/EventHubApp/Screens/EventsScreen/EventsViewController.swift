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
    private var isUpcomingSelected = true

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

    private let noBookmarksImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "calendar")
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
        label.textColor = .black
        label.text = "No upcoming events"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.isHidden = false
        return label
    }()
    
    private lazy var toggleSegmentedControl: UISegmentedControl = {
        let items = ["Upcoming", "Past"]
        let segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.layer.cornerRadius = 30
        segmentedControl.layer.masksToBounds = true
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0 // Default selection
        segmentedControl.addTarget(self, action: #selector(toggleOptionChanged(_:)), for: .valueChanged)
        return segmentedControl
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
        print(eventsArray.count)
    }
    
    @objc private func toggleOptionChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("Upcoming selected")
            noBookmarksLabel.text = "No upcoming events"
        } else {
            print("Past selected")
            noBookmarksLabel.text = "No past events"
        }
    }
    
    
    
}

// MARK: - Private Methods
private extension EventsViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(noBookmarksImage)
        view.addSubview(noBookmarksLabel)
        view.addSubview(toggleSegmentedControl)
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

            collectionView.topAnchor.constraint(equalTo: toggleSegmentedControl.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            noBookmarksImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noBookmarksImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noBookmarksImage.widthAnchor.constraint(equalToConstant: 150),
            noBookmarksImage.heightAnchor.constraint(equalToConstant: 150),
            
            noBookmarksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noBookmarksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            noBookmarksLabel.topAnchor.constraint(equalTo: noBookmarksImage.bottomAnchor, constant: 30),
            
            toggleSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            toggleSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleSegmentedControl.widthAnchor.constraint(equalToConstant: 200),
            toggleSegmentedControl.heightAnchor.constraint(equalToConstant: 30)
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



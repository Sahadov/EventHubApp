//
//  EventDetailsVC.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 22.11.2024.
//

import UIKit

class EventDetailsVC: UIViewController {
    var presenter: PresenterOutput!
    var eventImage: EventImage?

    var dateCell = EventDetailsCell(image: "DateIcon", titleUp: "titleUp", titleDown: "titleDown", fontUp: nil, fontDown: nil)
    let locationCell = EventDetailsCell(image: "LocationIcon", titleUp: "locationUp", titleDown: "locationDown", fontUp: nil, fontDown: nil)
    let organizerCell = EventDetailsCell(image: "organizerIcon", titleUp: "organizerUp", titleDown: "organizerDown", fontUp: .airbnbFont(ofSize: 15, weight: .book), fontDown: .airbnbFont(ofSize: 12, weight: .book))
    
    let imageView = UIImageView()
    let scrollView = UIScrollView()
    let labelTitle = UILabel()
    let titleAboutEvent = UILabel()
    let textViewDescription = UITextView()
    let buttonBack = UIButton()
    var buttonBookmark = UIButton()
    let buttonShared = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        presenter?.getCheckEvent()
        //        proverkaEvent(event: event)
    }
    //    func proverkaEvent(event: EventModel){
    //        if CoreDataManager.shared.fetchFavouriteEvent(withId: Int64((event.id)!)) != nil {
    //            buttonBookmark.setImage(UIImage(named: "bookmarkIconRed"), for: .normal)
    //
    //                    }else{
    //                        buttonBookmark.setImage(UIImage(named: "bookmarkIcon"), for: .normal)
    //            }
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.getEvent()
        setupNavBar()
        setupView()
        setupConstraints()
        configuration()
    }
    
    func setConfigureNetwork(with event: EventModel) {
        if let imageStringURL = event.images?.first?.image,
           let imageURL = URL(string: imageStringURL) {
            NetworkManager.shared.fetchImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(named: "eventDetails")
                    }
                    print("Failed to fetch image: \(error.localizedDescription)")
                }
            }
        }
        
        if let imageOrganizerStringURL = event.participants?.first?.agent?.images?.first?.image,
           let imageURL = URL(string: imageOrganizerStringURL) {
            NetworkManager.shared.fetchImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.organizerCell.imageTitle.image = UIImage(data: data)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.organizerCell.imageTitle.image = UIImage(named: "organizerIcon")
                    }
                    print("Failed to fetch image: \(error.localizedDescription)")
                }
            }
        }
        
        if let firstDate = event.dates?.last {
            if firstDate.start == firstDate.end {
                dateCell.titleLabelUp.text = formatDate(from: event.dates?.last?.start ?? 0)
            } else {
                dateCell.titleLabelUp.text =  formatDate(from: firstDate.start ?? 0) + " - " +  formatDate(from: firstDate.end ?? 0)
            }
        }
        
        if let timeDate = event.dates?.last {
            if timeDate.start == timeDate.end {
                dateCell.titleLabelDown.text = formatDayOfWeek(from: timeDate.start ?? 0) + formatTime(from: timeDate.start ?? 0)
            } else {
                dateCell.titleLabelDown.text = formatDayOfWeek(from: timeDate.start ?? 0) + formatTime(from: timeDate.start ?? 0) + " - " + formatDayOfWeek(from: timeDate.end ?? 0) + formatTime(from: timeDate.end ?? 0)
            }
        }
        
        locationCell.titleLabelUp.text = event.place?.title?.capitalized ?? "The place is not specified"
        locationCell.titleLabelDown.text = event.place?.address?.capitalized ?? "The address is not specified"
        
        organizerCell.titleLabelUp.text = event.participants?.first?.agent?.title ?? "Unknown Name"
        organizerCell.titleLabelDown.text = event.participants?.first?.agent?.agentType?.capitalized ?? "Unknow Agent Type"
        labelTitle.text = event.title?.capitalized ?? "Unknown Event Title"
        textViewDescription.text = event.bodyText
    }
    
    func formatDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
    
    func formatDayOfWeek(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, "
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
    
    func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    
    private func setupView() {
        view.addSubview(imageView)
        view.addSubview(buttonShared)
        view.addSubview(scrollView)
        scrollView.addSubview(labelTitle)
        scrollView.addSubview(dateCell)
        scrollView.addSubview(locationCell)
        scrollView.addSubview(organizerCell)
        scrollView.addSubview(titleAboutEvent)
        scrollView.addSubview(textViewDescription)
    }
    
    private func setupNavBar() {
        navigationItem.title = "Event Details"
        
        let configTitle: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: .init(24))]
        navigationController?.navigationBar.titleTextAttributes = configTitle
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonBack)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonBookmark)
    }
    
    private func configuration() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonBack.setImage(UIImage(named: "BackArrow"), for: .normal)
        buttonBack.addTarget(self, action: #selector (backButtonTapped), for: .touchUpInside)
        
        buttonBookmark.setImage(UIImage(named: "bookmarkIcon"), for: .normal)
        buttonBookmark.addTarget(self, action: #selector (bookmarkTapped), for: .touchUpInside)
        
        buttonShared.setImage(UIImage(named: "sharedIcon"), for: .normal)
        buttonShared.addTarget(self, action: #selector (sharedTapped), for: .touchUpInside)
        buttonShared.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize.height = view.frame.height
        
        labelTitle.font = .airbnbFont(ofSize: 35, weight: .book)
        labelTitle.numberOfLines = 0
        labelTitle.sizeToFit()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        dateCell.translatesAutoresizingMaskIntoConstraints = false
        locationCell.translatesAutoresizingMaskIntoConstraints = false
        organizerCell.translatesAutoresizingMaskIntoConstraints = false
        
        titleAboutEvent.font = .airbnbFont(ofSize: 18, weight: .medium)
        titleAboutEvent.sizeToFit()
        titleAboutEvent.text = "About Event"
        titleAboutEvent.translatesAutoresizingMaskIntoConstraints = false
        
        textViewDescription.isEditable = false
        textViewDescription.isScrollEnabled = false
        textViewDescription.font = .airbnbFont(ofSize: 16, weight: .book)
        
        textViewDescription.setContentHuggingPriority(.required, for: .vertical)
        textViewDescription.textAlignment = .natural
        textViewDescription.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func bookmarkTapped() {
        presenter.bookmarkButtonTapped()
        print("bookmarkTapped")
    }
    @objc private func sharedTapped() {
        presenter.sharedButtonTapped()
        print("sharedTapped")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3.5),
            
            buttonShared.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -15),
            buttonShared.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dateCell.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            dateCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateCell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateCell.widthAnchor.constraint(equalToConstant: 205),
            dateCell.heightAnchor.constraint(equalToConstant: 53),
            
            locationCell.topAnchor.constraint(equalTo: dateCell.bottomAnchor, constant: 20),
            locationCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationCell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationCell.widthAnchor.constraint(equalToConstant: 205),
            locationCell.heightAnchor.constraint(equalToConstant: 53),
            
            organizerCell.topAnchor.constraint(equalTo: locationCell.bottomAnchor, constant: 20),
            organizerCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            organizerCell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            organizerCell.widthAnchor.constraint(equalToConstant: 154),
            organizerCell.heightAnchor.constraint(equalToConstant: 44),
            
            titleAboutEvent.topAnchor.constraint(equalTo: organizerCell.bottomAnchor, constant: 44),
            titleAboutEvent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            textViewDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textViewDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textViewDescription.topAnchor.constraint(equalTo: titleAboutEvent.bottomAnchor, constant: 8),
            textViewDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30)
        ])
    }
}

extension EventDetailsVC: PresenterInput {
    func checkEvent(event: EventModel) {
        if CoreDataManager.shared.fetchFavouriteEvent(withId: Int64((event.id)!)) != nil {
            buttonBookmark.setImage(UIImage(named: "bookmarkIconRed"), for: .normal)
        }else{
            buttonBookmark.setImage(UIImage(named: "bookmarkIcon"), for: .normal)
        }
    }
    func showShareScreen() {
        let shareViewController = ShareViewController()
        navigationController?.present(shareViewController, animated: true)
    }
    func saveEvent(event: EventModel) {
        if CoreDataManager.shared.fetchFavouriteEvent(withId: Int64((event.id)!)) != nil {
            // Deleting from CoreData
            guard let updatedEvent = CoreDataManager.shared.fetchFavouriteEvent(withId: Int64((event.id)!)) else { return }
            CoreDataManager.shared.deleteFavouriteEvent(event: updatedEvent)
            buttonBookmark.setImage(UIImage(named: "bookmarkIcon"), for: .normal)
        } else {
            // Saving to CoreData
            let imageURL = (event.images?.first?.image)!
            let startDate = formatDate(from: event.dates?.first?.start ?? 0) + " - " +  formatDate(from: event.dates?.first?.end ?? 0)
            let eventDay = formatDayOfWeek(from: event.dates?.first?.start ?? 0) + formatTime(from: event.dates?.first?.start ?? 0)
            let place = event.place?.address?.capitalized ?? "The place is not specified"
            let location = event.place?.title?.capitalized ?? "The location is not specified"
            
            let agentName = event.participants?.first?.agent?.title ?? "Unknown Name"
            let agentType = event.participants?.first?.agent?.agentType?.capitalized ?? "Unknow Agent Type"
            
            _ = CoreDataManager.shared.createFavouriteEvent(userEmail: "mrsahadov@gmail.com", id: (event.id!), title: (event.title!), location: location, bodyText: (event.bodyText!), image: imageURL, startDate: startDate, eventDay: eventDay, place: place, agentName: agentName, agentType: agentType)
            buttonBookmark.setImage(UIImage(named: "bookmarkIconRed"), for: .normal)
        }
    }
    func setEvent(event: EventModel) {
        setConfigureNetwork(with: event)
    }
}

//@available(iOS 18.0, *)
//#Preview { (CustomTabBarController())
//}

//
//  EventDetailsVC.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 22.11.2024.
//

import UIKit

class EventDetailsVC: UIViewController {
    
    let dataCell = EventDetailsCell(image: "dateIcon", titleUp: "titleUp", titleDown: "titleDown", fontUp: nil, fontDown: nil)
    let locationCell = EventDetailsCell(image: "locationIcon", titleUp: "locationUp", titleDown: "locationDown", fontUp: nil, fontDown: nil)
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        setupConstraints()
        configuration()
    }
    
    private func setupView() {
        view.addSubview(imageView)
        view.addSubview(buttonShared)
        view.addSubview(scrollView)
        scrollView.addSubview(labelTitle)
        scrollView.addSubview(dataCell)
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
        imageView.image = UIImage(named: "eventDetails")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonBack.setImage(UIImage(named: "backArrow"), for: .normal)
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
        labelTitle.text = "International Band Music Concert"
        //            labelTitle.text = ("  \()  ")
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        dataCell.translatesAutoresizingMaskIntoConstraints = false
        locationCell.translatesAutoresizingMaskIntoConstraints = false
        organizerCell.translatesAutoresizingMaskIntoConstraints = false
        
        titleAboutEvent.font = .airbnbFont(ofSize: 18, weight: .medium)
        titleAboutEvent.sizeToFit()
        titleAboutEvent.text = "About Event"
        titleAboutEvent.translatesAutoresizingMaskIntoConstraints = false
        
        textViewDescription.isEditable = false
        textViewDescription.isScrollEnabled = false
        textViewDescription.font = .airbnbFont(ofSize: 16, weight: .book)
        textViewDescription.text = "International Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music ConcertInternational Band Music Concert"
        textViewDescription.setContentHuggingPriority(.required, for: .vertical)
        textViewDescription.textAlignment = .justified

        textViewDescription.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func bookmarkTapped() {
        print("bookmarkTapped")
    }
    @objc private func sharedTapped() {
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

            dataCell.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            dataCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dataCell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dataCell.widthAnchor.constraint(equalToConstant: 205),
            dataCell.heightAnchor.constraint(equalToConstant: 53),

            locationCell.topAnchor.constraint(equalTo: dataCell.bottomAnchor, constant: 20),
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

@available(iOS 18.0, *)
#Preview { (CustomTabBarController())
}

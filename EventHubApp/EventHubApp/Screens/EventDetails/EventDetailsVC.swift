//
//  EventDetailsVC.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 22.11.2024.
//

import UIKit

class EventDetailsVC: UIViewController {
    
//    var eventDetails:EventModel
       

        let imageView = UIImageView()
        let labelTitle = UILabel()
        let labelDescription = UILabel()
        let labelAuthor = UILabel()
        let textView = UITextView()
        let buttonBack = UIButton()
        var buttonBookmark = UIButton()
        let buttonShared = UIButton()
        
       
        
//    init(eventDetails: EventModel) {
//            self.eventDetails = eventDetails
//            super.init(nibName: nil, bundle: nil)
//        }
        
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.isHidden = false
            tabBarController?.tabBar.isHidden = false
            
        }
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            navigationController?.navigationBar.isHidden = true
//            tabBarController?.tabBar.isHidden = false
//        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupNavBar()
        setupView()
        setupConstraints()
        configuration()
    }
    
        private func setupView() {
            view.addSubview(imageView)
            view.addSubview(buttonShared)
            view.addSubview(labelTitle)
            view.addSubview(labelDescription)
            view.addSubview(labelAuthor)
            view.addSubview(textView)
        }
        
        private func setupNavBar() {
            navigationItem.title = "Event Details"
            
            //let spaceTitle: UIOffset = UIOffset(horizontal: -100, vertical: 0)
            
            let configTitle: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: .init(24))/*, .baselineOffset: UIOffset(horizontal: -100, vertical: -100)*/]
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
            
            labelTitle.font = .systemFont(ofSize: 12, weight: .semibold)
            labelTitle.textColor = .white
//            labelTitle.backgroundColor = .brandPurplePrimary
            labelTitle.layer.cornerRadius = 16
            labelTitle.sizeToFit()
            labelTitle.clipsToBounds = true
//            labelTitle.text = ("  \(article.source.name)  ")
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            
            labelDescription.font = .systemFont(ofSize: 20, weight: .bold)
            labelDescription.textColor = .white
            labelDescription.textAlignment = .left
            labelDescription.numberOfLines = 4
            labelDescription.clipsToBounds = true
            labelDescription.sizeToFit()
//            labelDescription.text = article.description
            labelDescription.translatesAutoresizingMaskIntoConstraints = false
            
            labelAuthor.textColor = .white
            labelAuthor.numberOfLines = 0
            labelAuthor.sizeToFit()
            labelAuthor.textAlignment = .left
            labelAuthor.clipsToBounds = true
            
            labelAuthor.translatesAutoresizingMaskIntoConstraints = false
            
            textView.isEditable = false
            textView.font = .systemFont(ofSize: 16, weight: .regular)
            textView.textColor = .black
            textView.textContainerInset = UIEdgeInsets( top: 20, left: 20, bottom: 0, right: 20)
            textView.setContentHuggingPriority(.required, for: .vertical)
            textView.textAlignment = .justified
            textView.translatesAutoresizingMaskIntoConstraints = false
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
                
                labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                labelTitle.heightAnchor.constraint(equalToConstant: 32),
                
                labelDescription.bottomAnchor.constraint(equalTo: labelAuthor.topAnchor, constant: -16),
                labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
                labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               
                
                labelAuthor.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: -24),
                labelAuthor.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
                labelAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                labelAuthor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                textView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
            ])
        }
        
    }

    @available(iOS 18.0, *)
#Preview { (CustomTabBarController())
}

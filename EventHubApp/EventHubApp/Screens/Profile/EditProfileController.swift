//
//  EditProfileController.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 23.11.2024.
//

import UIKit

final class EditProfileController: UIViewController {
    private let store = EditProfileStore()
    private var bag = Bag()
    
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let aboutTitleLabel = UILabel()
    private let aboutTextLabel = UILabel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.sendAction(.fetch)
    }
    
    private func showUserInfo(_ person: Person?) {
        if let person {
            nameLabel.text = person.username
            aboutTextLabel.text = person.about
            let url = URL(string: person.avatarLink)
            avatarImageView.kf.setImage(with: url)
        }
    }
}
// MARK: - Setup Views
private extension EditProfileController {
    func setupViews() {
        navigationItem.title = "Profile"
        setupAvatarImageView()
        setupNameLabel()
        setupAboutTitleLabel()
        setupAboutTextView()
        view.backgroundColor = .white
        setupObservers()
    }
    
    func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink {[weak self] event in
                switch event {
                case .done(let person): self?.showUserInfo(person)
                }
            }.store(in: &bag)
    }
    
    func setupAvatarImageView() {
        let radius = 48.0
        view.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.layer.cornerRadius = radius
        avatarImageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 2 * radius),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = ""
        nameLabel.textAlignment = .center
        nameLabel.font = .airbnbFont(ofSize: 24, weight: .book)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 21)
        ])
    }
    
    func setupAboutTitleLabel() {
        view.addSubview(aboutTitleLabel)
        aboutTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutTitleLabel.text = "About Me"
        aboutTitleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        aboutTitleLabel.textColor = .label
        NSLayoutConstraint.activate([
            aboutTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            aboutTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            aboutTitleLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    func setupAboutTextView() {
        view.addSubview(aboutTextLabel)
        aboutTextLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutTextLabel.numberOfLines = 0
        aboutTextLabel.font = .airbnbFont(ofSize: 16, weight: .book)
        aboutTextLabel.text = ""
        NSLayoutConstraint.activate([
            aboutTextLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: 50),
            aboutTextLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            aboutTextLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
}

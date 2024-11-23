//
//  ProfileViewController.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 19.11.2024.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {
    public var callback: Callback?
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let editButton = UIButton()
    private let aboutTitleLabel = UILabel()
    private let aboutTextLabel = UILabel()
    private let logoutButton = UIButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        for family in UIFont.familyNames.sorted() {
          let names = UIFont.fontNames(forFamilyName: family)
          print(family, names)
        }
    }
}
// MARK: - Setup Views
private extension ProfileViewController {
    func setupViews() {
        navigationItem.title = "Profile"
        setupAvatarImageView()
        setupNameLabel()
        setupEditButton()
        setupAboutTitleLabel()
        setupAboutTextView()
        setupLogoutButton()
        view.backgroundColor = .white
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
        nameLabel.text = "Ashfak Sayem"
        nameLabel.textAlignment = .center
        nameLabel.font = .airbnbFont(ofSize: 24, weight: .book)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 21)
        ])
    }
    
    func setupEditButton() {
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.title = "Edit Profile"
        config.background.backgroundColor = .clear
        config.background.strokeColor = AppColors.primaryBlue
        config.background.strokeWidth = 1.5
        config.baseForegroundColor = AppColors.primaryBlue
        config.image = UIImage(named: "edit")
        config.imagePlacement = .leading
        config.imagePadding = 16
        config.contentInsets = .init(top: 12, leading: 18, bottom: 12, trailing: 18)
        editButton.configuration = config
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupAboutTitleLabel() {
        view.addSubview(aboutTitleLabel)
        aboutTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutTitleLabel.text = "About Me"
        aboutTitleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        aboutTitleLabel.textColor = .label
        NSLayoutConstraint.activate([
            aboutTitleLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 50),
            aboutTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            aboutTitleLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    func setupAboutTextView() {
        view.addSubview(aboutTextLabel)
        aboutTextLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutTextLabel.numberOfLines = 0
        aboutTextLabel.font = .airbnbFont(ofSize: 16, weight: .book)
        aboutTextLabel.text = "Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More"
        NSLayoutConstraint.activate([
            aboutTextLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: 50),
            aboutTextLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            aboutTextLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    func setupLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.plain()
        config.title = "Sign Out"
        config.baseForegroundColor = .label
        config.image = UIImage(named: "logout")
        config.imagePlacement = .leading
        config.imagePadding = 16
        config.contentInsets = .init(top: 12, leading: 18, bottom: 12, trailing: 18)
        logoutButton.configuration = config
        logoutButton.addAction(UIAction {[weak self] _ in
            try? Auth.auth().signOut()
            self?.callback?()
        }, for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -40)
        ])
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    UINavigationController(rootViewController: ProfileViewController())
//}

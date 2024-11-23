//
//  ProfileViewController.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 19.11.2024.
//

import UIKit
import FirebaseAuth
import Kingfisher

final class ProfileViewController: UIViewController {
    public var callback: Callback?
    private let store = ProfileStore()
    private var bag = Bag()
    
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let editButton = UIButton()
    private let aboutTitleLabel = UILabel()
    private let aboutTextLabel = UILabel()
    private let logoutButton = UIButton()
        
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
        setupObservers()
    }
    
    func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink {[weak self] event in
                switch event {
                case .done(let person): self?.showUserInfo(person)
                case .signOut: self?.callback?()
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
        editButton.addAction(UIAction {[weak self] _ in
            self?.navigationController?.pushViewController(EditProfileController(), animated: true)
        }, for: .primaryActionTriggered)
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
        logoutButton.addAction(
            UIAction {[weak self] _ in
                self?.store.sendAction(.signOut)
            },
            for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -40)
        ])
    }
}

struct Person: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    let email: String
    var about = ""
    var pushId = ""
    var avatarLink = ""
    var fullname = ""
    var status = Status()
    var initials: String {
        String(username.first ?? "?")
    }
}

extension Person {
    static var currentId: String {
        Auth.auth().currentUser?.uid ?? ""
    }

    static var currentName: String {
        "Current Name"
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    static func chatRoomIdFrom(id: String) -> String {
        let value = id.compare(currentId).rawValue
        return value < 0 ? id + currentId : currentId + id
    }

}

extension Person {
    struct Status: Codable, Hashable {
        var index = 0
        var statuses = ["Available", "Busy", "At School"]
        var text: String {
            index < statuses.count ? statuses[index] : "No status"
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    UINavigationController(rootViewController: ProfileViewController())
//}

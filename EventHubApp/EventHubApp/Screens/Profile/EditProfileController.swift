//
//  EditProfileController.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 23.11.2024.
//

import UIKit
import PhotosUI

final class EditProfileController: UIViewController {
    private let store = EditProfileStore()
    private var bag = Bag()
    private var person: Person?
    private let avatarImageView = UIImageView()
    private let nameLabel = UITextField()
    private let aboutTitleLabel = UILabel()
    private let aboutTextLabel = UITextView()

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
            self.person = person
            nameLabel.text = person.username
            aboutTextLabel.text = person.about
            let url = URL(string: person.avatarLink)
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
        }
    }
    
    @objc private func save() {
        
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save)
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentPhotoPicker))
        avatarImageView.addGestureRecognizer(tap)
        avatarImageView.isUserInteractionEnabled = true
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
        nameLabel.delegate = self
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
        aboutTextLabel.font = .airbnbFont(ofSize: 16, weight: .book)
        aboutTextLabel.text = ""
        aboutTextLabel.delegate = self
        NSLayoutConstraint.activate([
            aboutTextLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: 50),
            aboutTextLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            aboutTextLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            aboutTextLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}
// MARK: -
extension EditProfileController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        if textField == nameLabel, let name = textField.text, !name.isEmpty {
            store.sendAction(.updateUsername(name))
        }
        view.endEditing(true)
        return true
    }
}

extension EditProfileController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print(#function)
        return true
    }
}
// MARK: - PHPickerViewControllerDelegate
extension EditProfileController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let result = results.first else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
            guard let image = reading as? UIImage, error == nil else {
                print("Выберите другое изображение")
                return
            }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
            self.store.sendAction(.uploadImage(image))
        }
    }

    @objc private func presentPhotoPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}

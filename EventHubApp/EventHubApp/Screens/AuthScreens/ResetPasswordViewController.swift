//
//  ResetPasswordViewController.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    private let navigationBackButton = BackButton()
    private let titleLabel = TextLabel(text: "Reset Password", fontSize: 24, fontWeight: .medium)
    private let manualLabel = TextLabel(text: "Please enter your email address to request a password reset", fontSize: 15, fontWeight: .book)
    private let emailTF = AuthTextField(placeholder: "abc@email.com", keyboardType: .emailAddress, imageString: "emailAuth")
    private let resetPasswordButton = ActionButton(title: "SEND")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 240/255, green: 235/255, blue: 235/255, alpha: 1)
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationBackButton)
        
        setupViews()
        setConstraints()
    }
    
    @objc func resetPasswordTapped() {
        let vc = RepeatResetPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func navigationBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ResetPasswordViewController {
    private func setupViews() {
        [emailTF, manualLabel, resetPasswordButton].forEach { localView in
            view.addSubview(localView)
            localView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configure()
    }
    
    private func configure() {
        manualLabel.numberOfLines = 2
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)
        navigationBackButton.addTarget(self, action: #selector(navigationBackButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            manualLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59),
            manualLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            manualLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: manualLabel.bottomAnchor, constant: 26),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTF.heightAnchor.constraint(equalToConstant: 56)
        ])

        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 40),
            resetPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52),
            resetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -52),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
}

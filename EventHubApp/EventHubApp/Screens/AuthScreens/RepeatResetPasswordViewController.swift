//
//  RepeatResetPasswordViewController.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

class RepeatResetPasswordViewController: UIViewController {
    
    private let navigationBackButton = BackButton()
    private let titleLabel = TextLabel(text: "Reset Password", fontSize: 24, fontWeight: .medium)
    private let passwordTF = AuthTextField(placeholder: "Your password", keyboardType: .default, imageString: "emailAuth", togglePassword: true)
    private let repeatPasswordTF = AuthTextField(placeholder: "Confirm password", keyboardType: .default, imageString: "emailAuth", togglePassword: true)
    private let changePasswordButton = ActionButton(title: "CHANGE PASSWORD")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 240/255, green: 235/255, blue: 235/255, alpha: 1)
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationBackButton)
        
        setupViews()
        setConstraints()
    }
    
    @objc func signUpTapped() {
        print("signUpTapped")
    }

    @objc func navigationBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension RepeatResetPasswordViewController {
    private func setupViews() {
        [passwordTF, repeatPasswordTF, changePasswordButton].forEach { localView in
            view.addSubview(localView)
            localView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configure()
    }
    
    private func configure() {
        changePasswordButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        navigationBackButton.addTarget(self, action: #selector(navigationBackButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 71),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordTF.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 37),
            repeatPasswordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            repeatPasswordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            repeatPasswordTF.heightAnchor.constraint(equalToConstant: 56)
        ])

        NSLayoutConstraint.activate([
            changePasswordButton.topAnchor.constraint(equalTo: repeatPasswordTF.bottomAnchor, constant: 37),
            changePasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52),
            changePasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -52),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
}


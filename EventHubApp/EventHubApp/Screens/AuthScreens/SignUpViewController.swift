//
//  SignUpViewController.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

class SignUpViewController: UIViewController {
    public var callback: Callback?
    private let store = AuthStore()
    private var bag = Bag()

    private let navigationBackButton = BackButton()
    private let titleLabel = TextLabel(text: "Sign up", fontSize: 24, fontWeight: .medium)
    private let loginTF = AuthTextField(placeholder: "Full Name", keyboardType: .emailAddress, imageString: "emailAuth")
    private let emailTF = AuthTextField(placeholder: "abc@email.com", keyboardType: .emailAddress, imageString: "emailAuth")
    private let passwordTF = AuthTextField(placeholder: "Your password", keyboardType: .default, imageString: "emailAuth", togglePassword: true)
    private let repeatPasswordTF = AuthTextField(placeholder: "Confirm password", keyboardType: .default, imageString: "emailAuth", togglePassword: true)
    private let signUpButton = ActionButton(title: "SIGN UP")
    private let orLabel = TextLabel(text: "OR", fontSize: 16, fontWeight: .medium, textColor: AppColors.gray)
    private let googleButton = AuthGoogleButton(title: "Login with Google")
    private lazy var signUpFirstLabel = TextLabel(text: "Already have an account?", fontSize: 14, fontWeight: .book)
    private lazy var signUpSecondLabel = TextLabel(text: "Sign in", fontSize: 14, fontWeight: .book, textColor: AppColors.blue)
    private lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 240/255, green: 235/255, blue: 235/255, alpha: 1)
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationBackButton)
        
        setupViews()
        setConstraints()
    }
    
    
    @objc func forgotPasswordTapped() {
        print("forgotPasswordTapped")
    }
    
    @objc func signUpTapped() {
        guard let email = emailTF.text,
                let password = passwordTF.text,
                let repeatPassord = repeatPasswordTF.text,
                let name = loginTF.text, repeatPassord == password else { return }
        store.sendAction(.createUser(email, password, name))
    }

    
    @objc func navigationBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignUpViewController {
    private func setupViews() {
        [titleLabel, loginTF, emailTF, passwordTF, repeatPasswordTF, signUpButton, orLabel, googleButton, signUpStackView].forEach { localView in
            view.addSubview(localView)
            localView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [signUpFirstLabel, signUpSecondLabel].forEach { localView in
            signUpStackView.addArrangedSubview(localView)
            localView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configure()
        setupObservers()
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .login:            self.login()
                }
            }.store(in: &bag)
    }
    
    private func login() {
        callback?()
    }
    
    private func configure() {
        signUpSecondLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationBackButtonTapped))
        signUpSecondLabel.addGestureRecognizer(tapGesture)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture2)
        
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        navigationBackButton.addTarget(self, action: #selector(navigationBackButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            loginTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 71),
            loginTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            loginTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 19),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 19),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordTF.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 19),
            repeatPasswordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            repeatPasswordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            repeatPasswordTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: repeatPasswordTF.bottomAnchor, constant: 38),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -52),
            signUpButton.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        NSLayoutConstraint.activate([
            orLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            googleButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 25),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -52),
            googleButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            signUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
}


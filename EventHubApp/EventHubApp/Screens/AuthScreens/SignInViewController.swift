//
//  AuthViewController.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

class SignInViewController: UIViewController {
    public var callback: Callback?
    private let store = AuthStore()
    private var bag = Bag()
    
    private let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private let titleLabel = TextLabel(text: "Sign in", fontSize: 24, fontWeight: .medium)
    
    private let emailTF = AuthTextField(placeholder: "abc@email.com", keyboardType: .emailAddress, imageString: "emailAuth")
    private let passwordTF = AuthTextField(placeholder: "Your password", keyboardType: .default, imageString: "emailAuth", togglePassword: true)
    
    
    private let switchContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let rememberMeSwitch: UISwitch = {
        let customSwitch = UISwitch()
        customSwitch.onTintColor = AppColors.blue
        customSwitch.thumbTintColor = .white
        customSwitch.isOn = true
        return customSwitch
    }()
    
    private let rememberMeLabel = TextLabel(text: "Remember me", fontSize: 14, fontWeight: .book)
    private let forgotPasswordLabel = TextLabel(text: "Forgot Password?", fontSize: 14, fontWeight: .book)
    
    private let signInButton = ActionButton(title: "SIGN IN")
    
    private let orLabel = TextLabel(text: "OR", fontSize: 16, fontWeight: .medium, textColor: AppColors.gray)
    
    private let googleButton = AuthGoogleButton(title: "Login with Google")
    
    private let signUpFirstLabel = TextLabel(text: "Don’t have an account?", fontSize: 14, fontWeight: .book)
    private let signUpSecondLabel = TextLabel(text: "Sign up", fontSize: 14, fontWeight: .book, textColor: AppColors.blue)
    
    private let signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 240/255, green: 235/255, blue: 235/255, alpha: 1)
        
        setupViews()
        setConstraints()
    }
    
    
    @objc func forgotPasswordTapped() {
        let vc = ResetPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signInTapped() {
        guard let email = emailTF.text, let password = passwordTF.text else { return }
        store.sendAction(.signIn(email, password))
    }
    
    @objc func signUpTapped() {
        let vc = SignUpViewController()
        vc.callback = callback
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignInViewController {
    private func setupViews() {
        [logoImageView, titleLabel, emailTF, passwordTF, switchContainer, rememberMeLabel,
         forgotPasswordLabel, signInButton, orLabel, googleButton, signUpStackView].forEach { localView in
            view.addSubview(localView)
            localView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        rememberMeSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        switchContainer.addSubview(rememberMeSwitch)
        rememberMeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
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
        forgotPasswordLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPasswordLabel.addGestureRecognizer(tapGesture)
        
        signUpSecondLabel.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(signUpTapped))
        signUpSecondLabel.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture3)
        
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46.5),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 29),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
        ])
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22),
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
            switchContainer.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 20),
            switchContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            switchContainer.heightAnchor.constraint(equalToConstant: 20),
            switchContainer.widthAnchor.constraint(equalToConstant: 33),
            
            rememberMeSwitch.centerXAnchor.constraint(equalTo: switchContainer.centerXAnchor),
            rememberMeSwitch.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),
            //            rememberMeSwitch.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        NSLayoutConstraint.activate([
            rememberMeLabel.centerYAnchor.constraint(equalTo: rememberMeSwitch.centerYAnchor),
            rememberMeLabel.leadingAnchor.constraint(equalTo: rememberMeSwitch.trailingAnchor, constant: 20),
            rememberMeLabel.trailingAnchor.constraint(lessThanOrEqualTo: forgotPasswordLabel.leadingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            forgotPasswordLabel.centerYAnchor.constraint(equalTo: rememberMeSwitch.centerYAnchor),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: rememberMeLabel.bottomAnchor, constant: 30),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -52),
            signInButton.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        NSLayoutConstraint.activate([
            orLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
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

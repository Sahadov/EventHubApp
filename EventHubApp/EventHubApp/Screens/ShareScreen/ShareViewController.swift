//
//  ShareViewController.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/23/24.
//

import UIKit

class ShareViewController: UIViewController {

    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 0.5)
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Share with friends"
        label.textAlignment = .left
        label.font = .airbnbFont(ofSize: 24, weight: .medium)
        label.textColor = AppColors.black
        return label
    }()
    
    private let shareCollectionView = ShareCollectionViewController()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor(red: 72/255, green: 70/255, blue: 70/255, alpha: 1), for: .normal)
        button.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 239/255, alpha: 1)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shareCollectionView.view.backgroundColor = .white
        
        setupViews()
        setConstraints()
    }

    @objc private func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleTapOutside(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
            if !containerView.frame.contains(location) {
                dismiss(animated: true, completion: nil)
            }
    }
    
    @objc private func handleAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension ShareViewController {
    private func setupViews() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, cancelButton, line].forEach() {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addChild(shareCollectionView)
        shareCollectionView.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(shareCollectionView.view)
        
        configure()
    }
    
    private func configure() {
        cancelButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5.81),
            line.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: 26),
            line.heightAnchor.constraint(equalToConstant: 2.4224)
        ])
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            shareCollectionView.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            shareCollectionView.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28),
            shareCollectionView.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -28),
            shareCollectionView.view.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -35),
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 52),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -52),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -23),
            cancelButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
}

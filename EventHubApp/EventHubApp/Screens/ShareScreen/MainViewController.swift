//
//  MainViewController.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/23/24.
//

import UIKit

class MainViewController: UIViewController {
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    @objc func shareButtonTapped() {
        let vc = ShareViewController(url: "")
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
}

extension MainViewController {
    private func setupViews() {
        [shareButton].forEach() {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            configure()
        }
    }
    
    private func configure() {
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

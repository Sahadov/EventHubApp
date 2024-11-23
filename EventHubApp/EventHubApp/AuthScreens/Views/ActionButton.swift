//
//  ActionButton.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

final class ActionButton: UIButton {

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "buttonArrow")
        return imageView
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        configure()
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Configure
private extension ActionButton {
    func configure() {
        self.titleLabel?.font = .airbnbFont(ofSize: 16, weight: .medium)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = AppColors.blue
        self.layer.cornerRadius = 16
    }
    
    func setupViews() {
        self.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 30),
            arrowImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}



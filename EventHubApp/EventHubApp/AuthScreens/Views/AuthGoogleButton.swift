//
//  AuthGoogleButton.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

final class AuthGoogleButton: UIButton {

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "google")
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
private extension AuthGoogleButton {
    func configure() {
        self.titleLabel?.font = .airbnbFont(ofSize: 14, weight: .normal)
        self.setTitleColor(AppColors.black, for: .normal)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
    }
    
    func setupViews() {
        self.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 37),
            arrowImageView.widthAnchor.constraint(equalToConstant: 26),
            arrowImageView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
}

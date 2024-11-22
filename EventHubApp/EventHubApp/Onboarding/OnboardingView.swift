//
//  Untitled.swift
//  EventHubApp
//
//  Created by Andrew Linkov on 18.11.2024.
//
import UIKit
import SwiftUI

//MARK: - Protocols
protocol OnboardingView: UIView {
    func setPageLabelTransform(transform: CGAffineTransform)
    var imageView: UIImageView { get }
}

class OnboardingViewImpl: UIView, OnboardingView {
    
    internal let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 16
        return image
    }()
    
    internal let downView: UIView = {
        let image = UIView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.layer.cornerRadius = 45
        return image
    }()
    
    internal let pageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [imageView, downView, pageLabel, descriptionLabel].forEach(addSubview)
    }

    func setupSlideUI(
        image: String,
        title: String?,
        description: String,
        nextButtonTitle: String,
        target: AnyObject?,
        action: Selector?
    ) {
            
        imageView.image = UIImage(named: image)
        pageLabel.text = title
        descriptionLabel.text = description
    }
    
    public func setPageLabelTransform(transform: CGAffineTransform) {
        imageView.transform = transform
    }
    
    // MARK: - setupConstraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55),
            
            downView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            downView.leadingAnchor.constraint(equalTo: leadingAnchor),
            downView.trailingAnchor.constraint(equalTo: trailingAnchor),
            downView.heightAnchor.constraint(equalTo: heightAnchor, constant: 274),

            
            pageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            pageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 15),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 295),
            

        ])
    }
}

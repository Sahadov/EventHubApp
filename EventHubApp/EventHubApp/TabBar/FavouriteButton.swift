//
//  FavouriteButton.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 18.11.2024.
//

import UIKit

final class FavouriteButton: UIButton {
    
    var onTap: (() -> Void)?
    
    //MARK: Button View Settings
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    @objc func buttonTapped() {
       onTap?()
    }
}

//MARK: Configure
private extension FavouriteButton {
    func configure() {
        tintColor = .white
        backgroundColor = AppColors.blue
    
        if let originalImage = UIImage(named: "bookmarkTabBar") {
                let resizedImage = originalImage.withConfiguration(
                    UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
                )
                setImage(resizedImage, for: .normal)
        }
        
        layer.shadowColor = AppColors.blue.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}


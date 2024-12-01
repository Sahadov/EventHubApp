//
//  BackButton.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

final class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BackButton {
    private func configure() {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        let image = UIImage(systemName: "arrow.left")?.withConfiguration(config)
        setImage(image, for: .normal)
        tintColor = AppColors.black
    }
}

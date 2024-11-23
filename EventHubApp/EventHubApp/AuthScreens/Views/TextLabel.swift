//
//  TextLabel.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

final class TextLabel: UILabel {
    
    init(text: String, alignment: NSTextAlignment = .left, fontSize: CGFloat, fontWeight: UIFont.AirbnbFont, textColor: UIColor = AppColors.black) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = alignment
        self.font = .airbnbFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TextLabel {
    private func configure() {
//        isUserInteractionEnabled = false
    }
}




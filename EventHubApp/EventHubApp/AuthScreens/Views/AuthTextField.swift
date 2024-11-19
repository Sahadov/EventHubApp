//
//  AuthTextField.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/19/24.
//

import UIKit

final class AuthTextField: UITextField {
    
    var imageString: String?
    var togglePassword: Bool = false
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default, isSecure: Bool = false, imageString: String, togglePassword: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecure
        self.imageString = imageString
        self.togglePassword = togglePassword
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Configure
private extension AuthTextField {
    func configure() {
        backgroundColor = .white
        font = .airbnbFont(ofSize: 14, weight: .normal)
        textAlignment = .left
        layer.borderWidth = 1
        layer.cornerRadius = 12
        layer.borderColor = AppColors.gray.cgColor
        autocorrectionType = .no
        spellCheckingType = .no
        
        if let originalImage = UIImage(named: imageString!) {
            let resizedImage = originalImage.withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 22, weight: UIImage.SymbolWeight(rawValue: 22)!)
            )
            let iconView = UIImageView(image: resizedImage)
            iconView.tintColor = AppColors.gray
            iconView.contentMode = .center
            
            let paddingView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: 22 + 15 + 14,
                height: 22 + 17 + 17
            ))
            
            iconView.frame = CGRect(
                x: 15,
                y: 17,
                width: 22,
                height: 22
            )
            
            paddingView.addSubview(iconView)
            self.leftView = paddingView
            self.leftViewMode = .always
            
        }

        if togglePassword {
            let toggleButton = UIButton()
            toggleButton.setImage(UIImage(named: "hiddenPassword"), for: .normal)
            toggleButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
            toggleButton.tintColor = .gray
            self.isSecureTextEntry = true
            
            toggleButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
            
            self.rightView = toggleButton
            self.rightViewMode = .always
            
            // Контейнер с кастомными отступами
            let paddingView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: 24 + 16,
                height: 24 + 16 + 16
            ))
            
            toggleButton.frame = CGRect(
                x: 5,
                y: 16,
                width: 24,
                height: 24
            )
            
            paddingView.addSubview(toggleButton)
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.isSecureTextEntry.toggle()
    }
}




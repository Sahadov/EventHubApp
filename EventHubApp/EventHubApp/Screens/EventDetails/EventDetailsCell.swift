//
//  EventDetailsCell.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 27.11.2024.
//

import UIKit

class EventDetailsCell: UIView {
    
    let imageTitle = UIImageView()
    let titleLabelUp = UILabel()
    let titleLabelDown = UILabel()
    
    init(image: String, titleUp: String, titleDown: String, fontUp: UIFont?, fontDown: UIFont?){
        super.init(frame: .zero)
        
        imageTitle.image = UIImage(named: image)
        titleLabelUp.text = titleUp
        titleLabelUp.font? = fontUp ?? .airbnbFont(ofSize: 16, weight: .medium)
        titleLabelDown.text = titleDown
        titleLabelDown.font? = fontDown ?? .airbnbFont(ofSize: 12, weight: .book)
        
        configuration()
        setupSubview()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview(){
        addSubview(imageTitle)
        addSubview(titleLabelUp)
        addSubview(titleLabelDown)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            imageTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabelUp.topAnchor.constraint(equalTo: topAnchor),
            titleLabelUp.leadingAnchor.constraint(equalTo: imageTitle.trailingAnchor, constant: 20),
            titleLabelUp.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabelDown.topAnchor.constraint(equalTo: titleLabelUp.bottomAnchor),
            titleLabelDown.leadingAnchor.constraint(equalTo: imageTitle.trailingAnchor, constant: 20),
        ])
    }
    
    private func configuration() {
        imageTitle.contentMode = .scaleAspectFit
        imageTitle.clipsToBounds = true
        imageTitle.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabelUp.textAlignment = .left
        titleLabelUp.numberOfLines = 0
        titleLabelUp.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabelDown.textColor = .gray
        titleLabelDown.textAlignment = .left
        titleLabelDown.numberOfLines = 0
        titleLabelDown.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

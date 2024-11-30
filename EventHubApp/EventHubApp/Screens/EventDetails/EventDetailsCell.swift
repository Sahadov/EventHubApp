//
//  EventDetailsCell.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 27.11.2024.
//

//
//  SettingRowView.swift
//  RadioApp
//
//  Created by Сергей Сухарев on 29.07.2024.
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
//            imageTitle.topAnchor.constraint(equalTo: topAnchor),
            imageTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            
//            imageTitle.widthAnchor.constraint(equalToConstant: 48),
//            imageTitle.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabelUp.topAnchor.constraint(equalTo: imageTitle.topAnchor),
            titleLabelUp.leadingAnchor.constraint(equalTo: imageTitle.trailingAnchor, constant: 20),
            
            titleLabelDown.bottomAnchor.constraint(equalTo: imageTitle.bottomAnchor),
            titleLabelDown.leadingAnchor.constraint(equalTo: imageTitle.trailingAnchor, constant: 20),
        ])
    }
    private func configuration() {
        imageTitle.contentMode = .scaleAspectFill
        imageTitle.clipsToBounds = true
       // imageTitle.isUserInteractionEnabled = true
        imageTitle.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabelUp.textAlignment = .left
        //titleLabelUp.font = .airbnbFont(ofSize: 16, weight: .medium)
        titleLabelUp.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabelDown.textColor = .gray
        titleLabelDown.textAlignment = .left
        //titleLabelDown.font = .airbnbFont(ofSize: 12, weight: .book)
        titleLabelDown.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

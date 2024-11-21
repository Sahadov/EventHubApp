//
//  FavouriteCell.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 20.11.2024.
//

import UIKit

class FavouriteCell: UICollectionViewCell {
    
    let dateLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.textColor = AppColors.blue
        title.font = .airbnbFont(ofSize: 15, weight: .light)
        return title
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .left
        title.tintColor = .black
        title.font = .airbnbFont(ofSize: 18, weight: .medium)
        return title
    }()
    
    let locationLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .left
        title.textColor = .systemGray
        title.font = .airbnbFont(ofSize: 15, weight: .light)
        return title
    }()
    
    let locationImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "mapTabBar")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setCell()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(){
        addSubview(titleLabel)
        [dateLabel, titleLabel, locationImageView, locationLabel, imageView].forEach { addSubview($0) }
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 85),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            locationImageView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            locationImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            locationImageView.heightAnchor.constraint(equalToConstant: 18),
            locationImageView.widthAnchor.constraint(equalToConstant: 18),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 3),
            locationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
        ])
    }
    
    // Configure Method
    func configure(with article: MyEvent) {
        dateLabel.text = article.date
        titleLabel.text = article.title
        locationLabel.text = article.place
        imageView.image = UIImage(named: "EventExample")
    }
}


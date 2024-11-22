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
    
    let eventImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    let bookmarkImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "bookmark")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setCell()
        setConstraints()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(){
        [dateLabel, titleLabel, locationImageView, locationLabel, eventImageView, bookmarkImageView].forEach { contentView.addSubview($0) }
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            eventImageView.widthAnchor.constraint(equalToConstant: 85),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            locationImageView.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            locationImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            locationImageView.heightAnchor.constraint(equalToConstant: 18),
            locationImageView.widthAnchor.constraint(equalToConstant: 18),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 3),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            bookmarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: 20),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    // Configure Method
    func configure(with article: MyEvent) {
        dateLabel.text = article.date
        titleLabel.text = article.title
        locationLabel.text = article.place
        eventImageView.image = UIImage(named: "EventExample")
    }
    
    private func setupShadow() {
        // Cell's layer configuration
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowColor = AppColors.blue.cgColor
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.masksToBounds = false // Allows shadow to extend outside

        // Adjust contentView to not clip to bounds
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white

        // Add padding to the contentView to leave space for the shadow
        contentView.frame = bounds.insetBy(dx: 5, dy: 5)
        contentView.layer.cornerRadius = 10
    }
}

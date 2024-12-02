//
//  FavouriteCell.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 20.11.2024.
//

import UIKit


protocol FavouriteCellDelegate: AnyObject {
    func didTapBookmarkButton(id: Int64)
}

class FavouriteCell: UICollectionViewCell {
    
    var id: Int64?
    
    weak var delegate: FavouriteCellDelegate?
    
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
        title.numberOfLines = 2
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
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        button.tintColor = AppColors.red
        button.contentMode = .scaleAspectFill
        return button
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
        [dateLabel, titleLabel, locationImageView, locationLabel, eventImageView, bookmarkButton].forEach { contentView.addSubview($0) }
        bookmarkButton.addTarget(self, action: #selector(bookmarkTaped), for: .touchUpInside)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            eventImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            eventImageView.widthAnchor.constraint(equalToConstant: 80),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -3),
            titleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 15),
            locationImageView.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 15),
            locationImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            locationImageView.heightAnchor.constraint(equalToConstant: 18),
            locationImageView.widthAnchor.constraint(equalToConstant: 18),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 3),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            bookmarkButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 20),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    // Configure Method
    func configure(with article: FavouriteEvent) {
        id = article.id
        dateLabel.text = "Date"
        titleLabel.text = article.title?.capitalized
        locationLabel.text = article.location
        
        if let imageURL = URL(string: article.image!) {
            NetworkManager.shared.fetchImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.eventImageView.image = UIImage(data: data)
                    }
                case .failure(let error):
                    print("Failed to fetch image: \(error.localizedDescription)")
                }
            }
        }
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
    
    @objc func bookmarkTaped() {
        delegate?.didTapBookmarkButton(id: id!)
    }
    
}

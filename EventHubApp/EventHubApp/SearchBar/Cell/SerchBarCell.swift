////
////  SerchBarCell.swift
////  EventHubApp
////
////  Created by Andrew Linkov on 25.11.2024.
//
//import UIKit
//
//class BookmarkCell: UITableViewCell {
//    static let reuseID = "BookmarkCell"
//    
//    // MARK: - UI Components
//    private let bookmarkImage: UIImageView = {
//        let image = UIImageView()
//        image.layer.cornerRadius = 12
//        image.contentMode = .scaleAspectFit
//        image.clipsToBounds = true
//        return image
//    }()
//    
//    private let backView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 8
//        view.backgroundColor = .white
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 0.1
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.layer.shadowRadius = 4
//        return view
//    }()
//
//    private let categoryLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.InterRegular(ofSize: 14)
//        label.textColor = UIColor.greyPrimary
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    private let mainLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.InterBold(ofSize: 16)
//        label.textColor = UIColor.blackPrimary
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    // MARK: - Initializer
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configure()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Public Methods
//    func set(info: Article) {
//        if let imageUrl = info.urlToImage, let imageData = try? Data(contentsOf: imageUrl) {
//            bookmarkImage.image = UIImage(data: imageData)
//        } else {
//            bookmarkImage.image = UIImage(systemName: "onb2")
//        }
//        
//        categoryLabel.text = info.source.name
//        mainLabel.text = info.title
//    }
//
//    // MARK: - Private Methods
//    private func configure() {
//        contentView.addSubview(backView)
//        backView.addSubview(bookmarkImage)
//        backView.addSubview(categoryLabel)
//        backView.addSubview(mainLabel)
//        
//        backView.translatesAutoresizingMaskIntoConstraints = false
//        bookmarkImage.translatesAutoresizingMaskIntoConstraints = false
//        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
//        mainLabel.translatesAutoresizingMaskIntoConstraints = false
//    }
//    
//    private func setupConstraints() {
//        
//        NSLayoutConstraint.activate([
//            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
//            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
//            backView.heightAnchor.constraint(equalToConstant: 105)
//        ])
//        
//        NSLayoutConstraint.activate([
//            bookmarkImage.widthAnchor.constraint(equalToConstant: 96),
//            bookmarkImage.heightAnchor.constraint(equalToConstant: 96),
//            bookmarkImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8),
//            bookmarkImage.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
//        ])
//        
//
//        NSLayoutConstraint.activate([
//            categoryLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
//            categoryLabel.leadingAnchor.constraint(equalTo: bookmarkImage.trailingAnchor, constant: 8),
//            categoryLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8)
//        ])
//        
//        NSLayoutConstraint.activate([
//            mainLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
//            mainLabel.leadingAnchor.constraint(equalTo: bookmarkImage.trailingAnchor, constant: 8),
//            mainLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8),
//            mainLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8)
//        ])
//    }
//}
//

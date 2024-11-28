////
////  SearchBarEmptyView.swift
////  EventHubApp
////
////  Created by Andrew Linkov on 25.11.2024.
////
//
//import UIKit
//
//final class EmptyView: UIView {
//    
//    //MARK: - UI Components
//    var titleLabelBig: UILabel {
//        let label = UILabel()
//        label.text = "Bookmarks"
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .black
//        label.numberOfLines = 1
//        return label
//    }
//    
//    var messageLabel: UILabel {
//        let label = UILabel()
//        label.text = "You haven't saved any articles yet. Start reading and bookmarking them now"
//        label.font = .systemFont(ofSize: 16)
//        label.numberOfLines = 0
//        return label
//    }
//    
//    let greyImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "Ellipse")
//        return imageView
//    }()
//    
//    let bookImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "emptyStatePic")
//        return imageView
//    }()
//    
//    // MARK: - Initializer
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
////        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        [messageLabel, greyImageView].forEach { addSubview($0) }
//        greyImageView.addSubview(bookImageView)
//    }
//}
//
//extension EmptyView {
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            titleLabelBig.topAnchor.constraint(equalTo: self.topAnchor, constant: 72),
//            titleLabelBig.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            
//            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 418),
//            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            
//            greyImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 418),
//            greyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            
//            bookImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 418),
//            bookImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            
//        ])
//    }
//    
//}

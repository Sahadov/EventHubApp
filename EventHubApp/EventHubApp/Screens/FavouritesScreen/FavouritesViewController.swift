//
//  FavouritesViewController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 19.11.2024.
//

import UIKit


struct MyEvent {
    let date: String
    let title: String
    let place: String
}

protocol FavouritesViewInput: AnyObject {
    func onSignInTapped()
    func onSignUpTapped()
    func onFacebookTapped()
    func onGoogleTapped()
    func onForgotTapped()
    func onBackPressed()
}

class FavouritesViewController: UIViewController {
    
    // MARK: - Properties
    var viewOutput: FavouritesViewOutput!
    
    
    let eventsArray = [MyEvent(date: "11 November", title: "The big bang theory", place: "Moscow"),
                       MyEvent(date: "11 November", title: "The big bang theory", place: "Moscow"),
                       MyEvent(date: "11 November", title: "The big bang theory", place: "Moscow"),
                       MyEvent(date: "11 November", title: "The big bang theory", place: "Moscow")]
        
    
        

    // MARK: - Views
    var collectionView: UICollectionView!
    
    let noBookmarksLabel: UILabel = {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.textAlignment = .center
            title.numberOfLines = 0
            title.tintColor = .systemGray6
            title.text = "You haven't saved any articles yet. Start reading and bookmarking them now."
            title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            return title
        }()
    
    // MARK: - Initializers
    init(viewOtput: FavouritesViewOutput){
        super.init(nibName: nil, bundle: nil)
        self.viewOutput = viewOtput
        setupViews()
        setCollectionView()
        loadBookmarkdData()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
    func facebookPressed(){
        print("Facebook pressed")
    }
    func googlePressed(){
        print("Google pressed")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
    }
        
    private func loadBookmarkdData() {
        let isShown = true
        
        if isShown {
            noBookmarksLabel.isHidden = true
        } else {
            collectionView.isHidden = true
        
            }
    }

}

// MARK: - Layout
private extension FavouritesViewController {
    func setupLayout(){
        view.backgroundColor = .red
    }
}

// MARK: - LoginViewInput Delegate
extension FavouritesViewController: FavouritesViewInput {
    func onSignInTapped() {
        
    }
    
    func onSignUpTapped() {
    
    }
    
    func onFacebookTapped() {
        
    }
    
    func onGoogleTapped() {
        
    }
    
    func onForgotTapped() {
        
    }
    
    func onBackPressed() {
        
    }
    
}

private extension FavouritesViewController {
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        view.addSubview(noBookmarksLabel)
    }
}

private extension FavouritesViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noBookmarksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noBookmarksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noBookmarksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}

extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavouriteCell
        cell.configure(with: eventsArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width
        return CGSize(width: itemWidth, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let event = eventsArray[indexPath.row]
//        let articleViewController = ArticleViewController(with: article)
//        articleViewController.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(articleViewController, animated: true)
    }
}

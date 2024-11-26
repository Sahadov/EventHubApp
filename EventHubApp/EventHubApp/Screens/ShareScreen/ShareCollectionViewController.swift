//
//  ShareCollectionViewController.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/23/24.
//

import UIKit

class ShareCollectionViewController: UIViewController {
    
    var message = "https://example.com"
    
    private let reuseIdentifier = "ShareCollectionViewCell"
    let buttonsArray: [ButtonsShareModel] = [
        ButtonsShareModel(title: "Copy Link", imageNamed: "copyIcon"),
        ButtonsShareModel(
            title: "Message",
            imageNamed: "messageIcon",
            urlApp: "sms:?body=",
            idApp: nil
        ),
        ButtonsShareModel(
            title: "WhatsApp",
            imageNamed: "whatsappIcon",
            urlApp: "whatsapp://send?text=",
            idApp: "id310633997"
        ),
        ButtonsShareModel(
            title: "Mail",
            imageNamed: "facebookIcon",
            urlApp: "mailto:?subject=Check%20this%20out&body=",
            idApp: nil
        ),
        ButtonsShareModel(
            title: "Messenger",
            imageNamed: "messengerIcon",
            urlApp: "fb-messenger://share?link=",
            idApp: "id454638411"
        ),
        ButtonsShareModel(
            title: "Twitter",
            imageNamed: "twitterIcon",
            urlApp: "twitter://post?message=",
            idApp: "id333903271"
        ),
        ButtonsShareModel(
            title: "Instagram",
            imageNamed: "instagramIcon",
            urlApp: "instagram://share",
            idApp: "id389801252"
        ),
        ButtonsShareModel(
            title: "Skype",
            imageNamed: "skypeIcon",
            urlApp: "skype://chat?message=",
            idApp: "id304878510"
        ),
        ButtonsShareModel(
            title: "Instagram",
            imageNamed: "instagramIcon",
            urlApp: "instagram://share",
            idApp: "id389801252"
        )
    ]
    private var selectedIndexPath: IndexPath?
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 75, height: 70)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 16
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        view.backgroundColor = .clear
        
        setupViews()
        setConstraints()
        setDelegate()
        
        collectionView.register(ShareCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    private func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ShareCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShareCollectionViewCell
        cell.configure(text: buttonsArray[indexPath.row].title, imageNamed: buttonsArray[indexPath.row].imageNamed)
        return cell
    }
}

extension ShareCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let button = buttonsArray[indexPath.row]
        
        switch button.title {
        case "Copy Link":
            UIPasteboard.general.string = message
            print("Link copied!")
            dismiss(animated: true)
        case "WhatsApp":
            guard let urlApp = button.urlApp, let idApp = button.idApp else { return }
            buttonTapped(message: message, urlApp: urlApp, idApp: idApp)
            dismiss(animated: true)
        case "Mail":
            guard let urlApp = button.urlApp else { return }
            buttonTapped(message: message, urlApp: urlApp)
            dismiss(animated: true)
        case "Messenger":
            guard let urlApp = button.urlApp, let idApp = button.idApp else { return }
            buttonTapped(message: message, urlApp: urlApp, idApp: idApp)
            dismiss(animated: true)
        case "Twitter":
            guard let urlApp = button.urlApp, let idApp = button.idApp else { return }
            buttonTapped(message: message, urlApp: urlApp, idApp: idApp)
            dismiss(animated: true)
        case "Instagram":
            guard let urlApp = button.urlApp, let idApp = button.idApp else { return }
            buttonTapped(message: message, urlApp: urlApp, idApp: idApp)
            dismiss(animated: true)
        case "Skype":
            guard let urlApp = button.urlApp, let idApp = button.idApp else { return }
            buttonTapped(message: message, urlApp: urlApp, idApp: idApp)
            dismiss(animated: true)
        case "Message":
            guard let urlApp = button.urlApp else { return }
            buttonTapped(message: message, urlApp: urlApp)
            dismiss(animated: true)
        default:
            print("Unknown action")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func buttonTapped(message: String, urlApp: String, idApp: String? = nil) {
        let message = message
        let urlString = "\(urlApp)\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            guard let idApp = idApp else { return }
            openAppStore(for: idApp)
        }
    }
    
    private func openAppStore(for idApp: String) {
        if let appStoreURL = URL(string: "https://apps.apple.com/app/id\(idApp)") {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
}

extension ShareCollectionViewController {
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            //            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 160),
            view.heightAnchor.constraint(equalToConstant: 160)
        ])
        
    }
}
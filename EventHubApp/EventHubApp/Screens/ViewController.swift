//
//  ViewController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 17.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
//    private let networkManager = NetworkManager.shared
//    private var categories = [EventCategoryModel]()
//    private var result = [EventModel]()
    
    private lazy var label: UILabel = {
        var element = UILabel()
        element.text = "Title"
        element.font = .airbnbFont(ofSize: 30, weight: .light)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getEventCategories(typeURL: APIEndpoint.eventsCategoriesUrl(lang: "ru", page: 1))
        setupViews()
        setConstraints()
    }
    
//    private func getEventCategories(typeURL: APIEndpoint) {
//        let url = typeURL.url
//        self.networkManager.fetch([EventCategoryModel].self, from: url) { [weak self] result in
//            guard let self = self else { return}
//            switch result {
//            case .success(let categories):
//                self.categories = categories
//                print(categories)
////                self.result = event.results
////                print(result)
//                DispatchQueue.main.async {
//                    //self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    func setupViews(){
        view.backgroundColor = AppColors.blue
        view.addSubview(label)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}


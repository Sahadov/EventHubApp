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
    private let apiManager = APIManager.shared
        
        private var cities = [LocationModel]()
        private var eventCategories = [EventCategoryModel]()
        private var events: EventsModel?
        private var searchResult: SearchModel?
    
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
//        getCitiesFromManager(lang: "ru")
//        getEventCategoriesFromManager(lang: "ru")
//        вgetEventsFromManager(lang: "ru", location: "msk", page: 1)
//        doSearchFromManager(query: "выставка", location: "msk", page: 1, lang: "ru")
//        getWeekEventsFromService(lang: "ru", page: 1, location: "msk")
        setupViews()
        setConstraints()
    }
    func getCitiesFromManager(lang: String) {
            self.apiManager.getCities(lang: lang) { [weak self] result in
                switch result {
                case .success(let cities):
                    self?.cities = cities
                    print(cities)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func getEventCategoriesFromManager(lang: String) {
            self.apiManager.getEventCategories(lang: lang) { [weak self] result in
                switch result {
                case .success(let eventCategories):
                    self?.eventCategories = eventCategories
                    print(eventCategories)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func getEventsFromManager(lang: String, location: String, page: Int) {
            self.apiManager.getEvents(lang: lang, page: page, location: location) { [weak self] result in
                switch result {
                case .success(let events):
                    self?.events = events
                    print(events)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
//    func doSearchFromManager(query: String, location: String, page: Int, lang: String) {
//        self.apiManager.doSearch(query: query, location: location, page: page, lang: lang) { [weak self] result in
//            switch result {
//            case .success(let searchResult):
//                self?.searchResult = searchResult
//                print(searchResult)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    private func getWeekEventsFromService(lang: String, page: Int, location: String) {
            apiManager.getWeekEvents(lang: lang, page: page, location: location) { [weak self] result in
                switch result {
                case .success(let events):
    //                self.weekEvents = events
                    print(events)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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


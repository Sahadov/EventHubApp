//
//  APIManager.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 25.11.2024.
//

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    private let networkManager = NetworkManager.shared
    
    func getCities(lang: String, completion: @escaping(Result<[LocationModel], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .getCities(lang: lang)) else { return }
        print(url)
        networkManager.fetch(for: url, completion: completion)
    }
    
    func getEventCategories(lang: String, completion: @escaping(Result<[EventCategoryModel], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .getCategories(lang: lang)) else { return }
        print(url)
        networkManager.fetch(for: url, completion: completion)
    }
    
    func getEvents(lang: String, page: Int, location: String, completion: @escaping(Result<EventsModel, NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .getEnvents(lang: lang, location: location, page: page)) else { return }
        print(url)
        networkManager.fetch(for: url, completion: completion)
    }
    
    func doSearch(query: String, location: String, page: Int, lang: String, completion: @escaping(Result<SearchModel, NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .doSearch(query: query, location: location, page: page, lang: lang)) else { return }
        print(url)
        networkManager.fetch(for: url, completion: completion)
    }
}

//
//  APIEndpoint.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 21.11.2024.
//

import Foundation

enum APIEndpoint {

    enum link {
        case base
        case city
        case events
        case eventCategories
        case search
        
        
        var url: String {
            switch self {
            case .base:
                return "https://kudago.com/public-api/v1.4/"
            case .city:
                return "locations/"
            case .events:
                return "events/"
            case .eventCategories:
                return "event-categories/"
            case .search:
                return "search/"
            }
        }
    }
    
    case citiesUrl(lang: String, page: Int)
    case eventsUrl(lang: String, page: Int)
    case eventsCategoriesUrl(lang: String, page: Int)
    case searchUrl(query: String, lang: String, page: Int)
    
    var url: URL {
        switch self {
        case .citiesUrl(lang: let lang, page: let page):
            return URL(string: "\(link.base.url)\(link.city.url)?lang=\(lang)&page=\(page)")!
        case .eventsUrl(lang: let lang, page: let page):
            return URL(string: "\(link.base.url)\(link.events.url)?lang=\(lang)&page=\(page)")!
        case .eventsCategoriesUrl(lang: let lang, page: let page):
            return URL(string: "\(link.base.url)\(link.eventCategories.url)?lang=\(lang)&page=\(page)")!
        case .searchUrl(query: let query, lang: let lang, page: let page):
            return URL(string: "\(link.base.url)\(link.search.url)?q=\(query)&lang=\(lang)&page=\(page)")!
        }
    }
    
}

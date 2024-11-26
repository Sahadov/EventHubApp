//
//  APIEndpoint.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 21.11.2024.
//

enum APIEndpoints {
    case getCities(lang: String)
    case getCategories(lang: String)
    case getEnvents(lang: String, location: String?, page: Int?)
    case doSearch(query: String, location: String, page: Int, lang: String)
    
    var patch: String {
        switch self {
            
        case .getCities:
            return "/public-api/v1.4/locations/"
        case .getCategories:
            return "/public-api/v1.4/event-categories/"
        case .getEnvents:
            return "/public-api/v1.4/events/"
        case .doSearch:
            return "/public-api/v1.4/search/"
        }
    }
}

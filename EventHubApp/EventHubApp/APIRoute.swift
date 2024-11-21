//
//  APIRoute.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 21.11.2024.
//

import Foundation

enum APIRoute {
    case getNews(NewsRequest)
    
    var baseUrl: String {
        "https://kudago.com/public-api/v1.4/"
    }
    
    var fullUrl: String {
        switch self {
        case .getNews:
            return baseUrl + "news"
        }
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getNews(let request):
            return [
                URLQueryItem(name: "lang", value: request.lang),
                URLQueryItem(name: "fields", value: request.fields),
                URLQueryItem(name: "expand", value: request.expand),
                URLQueryItem(name: "order_by", value: request.orderBy),
                URLQueryItem(name: "text_format", value: request.textFormat),
                URLQueryItem(name: "ids", value: request.ids),
                URLQueryItem(name: "location", value: request.location),
                URLQueryItem(name: "actual_only", value: request.actualOnly.description)
            ]
        }
    }
    
    var request: URLRequest? {
        guard let url = URL(string: fullUrl),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else { return nil }
        components.queryItems = queryItems
        var request = URLRequest(url: components.url ?? url)
        request.httpMethod = httpMethod
        request.timeoutInterval = 10
        return request
    }
}

// MARK: - EventResponse
struct EventResponse: Codable {
    let count: Int
    let next: String
    let results: [NewsResult]
}

// MARK: - Result
struct NewsResult: Codable {
    let id, publicationDate: Int
    let title, slug: String
}

struct NewsRequest {
    var lang = ""
    var fields = ""
    var expand = ""
    var orderBy = ""
    var textFormat = ""
    var ids = ""
    var location = ""
    var actualOnly = "true"
}

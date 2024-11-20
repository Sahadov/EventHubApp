//
//  APIRoute.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 21.11.2024.
//

import Foundation

enum APIRoute {
    case getNews
    
    var baseUrl: String {
        "https://kudago.com/public-api/v1.4/"
    }
    
    var fullUrl: String {
        switch self {
        case .getNews:
            return baseUrl + "news/?lang=&fields=&expand=&order_by=&text_format=&ids=&location=&actual_only=true"
        }
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var request: URLRequest? {
        guard let url = URL(string: fullUrl) else { return nil }
        print(url)
        var request = URLRequest(url: url)
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

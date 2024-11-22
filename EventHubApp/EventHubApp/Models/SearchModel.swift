//
//  SearchModel.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 21.11.2024.
//

struct SearchModel: Decodable{
    let results: [SearchResult]
}

struct SearchResult: Decodable{
    let id: Int?
    let slug: String?
    let title: String?
    let description: String?
    let address: String?
    let location: String?
}

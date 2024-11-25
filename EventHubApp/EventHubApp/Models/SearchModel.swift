//
//  SearchModel.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 21.11.2024.
//

struct SearchModel: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let id: Int?
    let title: String?
    let favoritesCount: Int?
    let commentsCount: Int?
    let description: String?
    let ctype: String?
    let daterange: Daterange?
    let firstImage: FirstImage?
}

struct Daterange: Decodable {
    let startDate: Int?
    let startTime: Int?
    let start: Int?
    let endDate: Int?
    let endTime: Int?
    let end: Int?
}

struct FirstImage: Decodable {
    let image: String?
}

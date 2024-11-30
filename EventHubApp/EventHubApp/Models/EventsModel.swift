//
//  EventsModel.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 21.11.2024.
//
struct EventsModel: Decodable {
    let results: [EventModel]?
}

struct EventModel: Codable {
    let id: Int?
    let title: String?
    let shortTitle: String?
    let slug: String?
    let dates: [EventDate]?
    let bodyText: String?
    let location: LocationModel?
    let categories: [String]?
    let images: [EventImage]?
    let favoritesCount: Int?
    let place: PlaceModel?
}

struct EventDate: Codable {
    let start: Int?
    let end: Int?
}

struct EventImage: Codable {
    let image: String?
    let source: Source?
}

struct Source: Codable {
    let name: String?
    let link: String?
}

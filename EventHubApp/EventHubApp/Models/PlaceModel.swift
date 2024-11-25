//
//  PlaceModel.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 25.11.2024.
//

struct PlacesModel: Decodable {
    let results: [PlaceModel]
}

struct PlaceModel: Decodable {
    let id: Int?
    let title: String?
    let slug: String?
    let address: String?
    let timetable: String?
    let phone: String?
    let isStub: Bool?
    let bodyText, description: String?
    let siteURL, foreignURL: String?
    let coords: Coords?
    let subway: String?
    let favoritesCount: Int?
    let images: [Image]?
    let commentsCount: Int?
    let isClosed: Bool?
    let categories: [String]?
    let shortTitle: String?
    let tags: [String]?
    let location, ageRestriction: String?
    let disableComments, hasParkingLot: Bool?
}

// MARK: - Coords
struct Coords: Decodable {
    let lat: Double?
    let lon: Double?
}

// MARK: - Image
struct Image: Decodable {
    let image: String?
    let source: PlaceSource?
}

// MARK: - Source
struct PlaceSource: Decodable {
    let name: String?
    let link: String?
} 

//
//  EventsModel.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 21.11.2024.
//
struct EventsModel: Decodable {
    let results: [EventModel]
}

struct EventModel: Decodable {
    let id: Int?
    let title: String?
    let slug: String?
}

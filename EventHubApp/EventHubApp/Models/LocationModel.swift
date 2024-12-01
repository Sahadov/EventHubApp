//
//  LocationModel.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 21.11.2024.
//

struct LocationModel: Decodable {
    let slug: String?
    let name: String?
    let coords: Coords?
}

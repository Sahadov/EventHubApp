//
//  Favourites+CoreDataProperties.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 29.11.2024.
//
//

import Foundation
import CoreData


extension Favourites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: "Favourites")
    }

    @NSManaged private var eventsData: Data?
    @NSManaged public var email: String?

    public var events: [EventModel]? {
        get {
            guard let data = eventsData else { return nil }
            let decoder = JSONDecoder()
            return try? decoder.decode([EventModel].self, from: data)
        }
        set {
            let encoder = JSONEncoder()
            eventsData = try? encoder.encode(newValue)
        }
    }
}

extension Favourites: Identifiable {}


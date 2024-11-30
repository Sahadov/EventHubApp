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

    @NSManaged public var events: [EventModel]?
    @NSManaged public var email: String?

}

extension Favourites : Identifiable {

}

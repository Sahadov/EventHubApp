//
//  EventModelTransformer.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 30.11.2024.
//

import Foundation
import CoreData

@objc(EventModelTransformer)
class EventModelTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let events = value as? [EventModel] else { return nil }
        let encoder = JSONEncoder()
        return try? encoder.encode(events)
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([EventModel].self, from: data)
    }
}


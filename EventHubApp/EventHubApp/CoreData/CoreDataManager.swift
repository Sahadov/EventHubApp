//
//  CoreDataManager.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 30.11.2024.
//

import Foundation
import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "EventHubApp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
    
    @discardableResult
    func createFavouriteEvent(userEmail: String, title: String, location: String, date: String) -> FavouriteEvent? {
        let context = persistentContainer.viewContext
        let event = FavouriteEvent(context: context)

        event.userEmail = userEmail
        event.title = title
        event.location = location
        event.date = date

        do {
            try context.save()
            return event
        } catch let error {
            print("Failed to create: \(error)")
        }

        return nil
    }

    func fetchFavouriteEvents() -> [FavouriteEvent]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<FavouriteEvent>(entityName: "FavouriteEvent")

        do {
            let events = try context.fetch(fetchRequest)
            return events
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }

        return nil
    }

    func fetchFavouriteEvent(withTitle title: String) -> FavouriteEvent? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<FavouriteEvent>(entityName: "FavouriteEvent")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)

        do {
            let events = try context.fetch(fetchRequest)
            return events.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }

        return nil
    }

    func updateFavouriteEvent(event: FavouriteEvent) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }

    func deleteFavouriteEvent(event: FavouriteEvent) {
        let context = persistentContainer.viewContext
        context.delete(event)

        do {
            try context.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }

}


func DemoCoreData() {
    
    // Create
    guard let newEvent = CoreDataManager.shared.createFavouriteEvent(userEmail: "mrsahadov@gmail.com", title: "Фестиваль меда в Ростове", location: "Парк Революции", date: "15 октября") else { return }
     print("Created \(newEvent)")

    
    // Read
    guard let event = CoreDataManager.shared.fetchFavouriteEvent(withTitle: "Фестиваль меда в Ростове") else { return }
    print(event)
    guard let events = CoreDataManager.shared.fetchFavouriteEvents() else { return }
    print(events)

    // Update
    //CoreDataManager.shared.updateFavouriteEvent(event: <#T##FavouriteEvent#>)
    //guard let updatedEvent = CoreDataManager.shared.fetchFavouriteEvent(withTitle: "Фестиваль меда в Ростове") else { return }
    
    //Delete
    //CoreDataManager.shared.deleteFavouriteEvent(event: updatedEvent)
}

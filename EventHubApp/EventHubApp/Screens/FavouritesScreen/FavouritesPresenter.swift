//
//  FavouritesPresenter.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 19.11.2024.
//


import Foundation

protocol FavouritesViewOutput: AnyObject {
    func loadEvents()
    func goToSearch()
}

class FavouritesPresenter {

    // MARK: - Properties
    weak var viewInput: FavouritesViewInput?
    private var events: [MyEvent] = []
    
    // MARK: - Initializer
    init(viewInput: FavouritesViewInput? = nil) {
        self.viewInput = viewInput
    }
}

// MARK: - FavouritesViewOutput
extension FavouritesPresenter: FavouritesViewOutput {
    func loadEvents() {
        // Simulate loading data (could fetch from a database or API)
        events = [
            MyEvent(date: "11 November", title: "The Big Bang Theory", place: "Moscow"),
            MyEvent(date: "12 November", title: "Event Horizon", place: "Saint Petersburg"),
            MyEvent(date: "13 November", title: "Cosmic Journey", place: "Novosibirsk")
        ]
        
        viewInput?.updateEvents(events)

        if events.isEmpty {
            viewInput?.showNoBookmarksMessage()
        } else {
            viewInput?.hideNoBookmarksMessage()
            viewInput?.updateEvents(events)
        }
    }

    func goToSearch() {
        print("Search action triggered")
        viewInput?.onSearchTapped()
    }
}

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
    private var events: [FavouriteEvent] = []
    
    // MARK: - Initializer
    init(viewInput: FavouritesViewInput? = nil) {
        self.viewInput = viewInput
    }
}

// MARK: - FavouritesViewOutput
extension FavouritesPresenter: FavouritesViewOutput {
    func loadEvents() {
        // Simulate loading data (could fetch from a database or API)
        events = []
        
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

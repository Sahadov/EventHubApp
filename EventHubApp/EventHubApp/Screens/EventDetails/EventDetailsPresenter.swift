//
//  EventDetailsPresenter.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 22.11.2024.
//
protocol PresenterInput: AnyObject {
    func showShareScreen()
    func saveEvent()
    func setEvent(event: EventModel)
}

protocol PresenterOutput: AnyObject {
    func bookmarkButtonTapped()
    func sharedButtonTapped()
    func getEvent()
}

class EventDetailsPresenter: PresenterOutput {
    weak var view: PresenterInput!
    var eventModel: EventModel!
    func bookmarkButtonTapped() {
        view.saveEvent()
    }
    
    func sharedButtonTapped() {
        view.showShareScreen()
    }
    
    func getEvent() {
        view.setEvent(event: eventModel)
    }
}

//
//  EventDetailsPresenter.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 22.11.2024.
//
protocol PresenterInput: AnyObject {
    func showShareScreen()
    func saveEvent(event: EventModel)
    func setEvent(event: EventModel)
    func checkEvent(event: EventModel)
}

protocol PresenterOutput: AnyObject {
    func bookmarkButtonTapped()
    func sharedButtonTapped()
    func getEvent()
    func getCheckEvent()
}

class EventDetailsPresenter: PresenterOutput {
    weak var view: PresenterInput!
    var eventModel: EventModel!
    func bookmarkButtonTapped() {
        view.saveEvent(event: eventModel)
    }
    
    func sharedButtonTapped() {
        view.showShareScreen()
    }
    
    func getEvent() {
        view.setEvent(event: eventModel)
    }
    func getCheckEvent() {
        view.checkEvent(event: eventModel)
    }
}

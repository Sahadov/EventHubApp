import Foundation

protocol ExploreViewProtocol: AnyObject {
    func showCatigories(_ categories: [EventCategoryModel])
    func showUpcomingEvents(_ events: [EventModel])
    func showNearbyEvents(_ events: [EventModel])
}

protocol ExplorePresenterProtocol: AnyObject {
    func fetchCategories()
    func fetchUpcomingEvents()
    func fetchNearbyEvents()
}

final class ExplorePresenter: ExplorePresenterProtocol {

    // MARK: - Properties

    weak var view: ExploreViewProtocol?
    private let apiManager = APIManager.shared

    func fetchCategories() {
        apiManager.getEventCategories(lang: "ru") { [weak self] result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self?.view?.showCatigories(categories)
                }
            case .failure(let error):
                print("Failed to fetch categories: \(error.localizedDescription)")
            }
        }
    }

    func fetchUpcomingEvents() {
        apiManager.getEvents(lang: "ru", page: 1, location: "msk") { [weak self] result in
            switch result {
            case .success(let events):
                print("events \(events)")
                guard let events = events.results else { return }
                DispatchQueue.main.async {
                    self?.view?.showUpcomingEvents(events)
                }
            case .failure(let error):
                print("Failed to fetch upcoming events: \(error.localizedDescription)")
            }
        }
    }

    func fetchNearbyEvents() {
        apiManager.getNearbyEvents(lang: "ru", location: "msk", radius: 500) { [weak self] result in
            switch result {
            case .success(let events):
                print("events \(events)")
                guard let events = events.results else { return }
                DispatchQueue.main.async {
                    self?.view?.showNearbyEvents(events)
                }
            case .failure(let error):
                print("Failed to fetch nearby events: \(error.localizedDescription)")
            }
        }
    }
}

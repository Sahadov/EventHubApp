import Foundation

protocol ExploreViewProtocol: AnyObject {
    func showCities(_ cities: [LocationModel])
    func showCatigories(_ categories: [EventCategoryModel])
    func showUpcomingEvents(_ events: [EventModel])
    func showNearbyEvents(_ events: [EventModel])
}

protocol ExplorePresenterProtocol: AnyObject {
    func fetchCities()
    func fetchCategories()
    func fetchUpcomingEvents()
    func fetchNearbyEvents(lat: Double, lon: Double, radius: Int)
}

final class ExplorePresenter: ExplorePresenterProtocol {

    // MARK: - Properties

    weak var view: ExploreViewProtocol?
    private let apiManager = APIManager.shared

    func fetchCities() {
        apiManager.getCities(lang: "en") { [weak self] result in
            switch result {
                case .success(let cities):
                DispatchQueue.main.async {
                    self?.view?.showCities(cities)
                }
            case .failure(let error):
                print("Failed to fetch cities: \(error.localizedDescription)")
            }
        }
    }

    func fetchCategories() {
        apiManager.getEventCategories(lang: "en") { [weak self] result in
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
        apiManager.getUpcomingEnvents(lang: "en") { [weak self] result in
            switch result {
            case .success(let events):
                guard let events = events.results else { return }
                DispatchQueue.main.async {
                    self?.view?.showUpcomingEvents(events)
                }
            case .failure(let error):
                print("Failed to fetch upcoming events: \(error.localizedDescription)")
            }
        }
    }

    func fetchNearbyEvents(lat: Double, lon: Double, radius: Int) {
        apiManager.getNearbyEvents(lang: "en", lat: lat, lon: lon, radius: radius) { [weak self] result in
            switch result {
            case .success(let events):
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

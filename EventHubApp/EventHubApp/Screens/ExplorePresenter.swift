import Foundation

protocol ExploreViewProtocol: AnyObject {
    func showCatigories(_ categories: [EventCategoryModel])
    func showEvents(_ events: [EventModel])
}

protocol ExplorePresenterProtocol: AnyObject {
    func fetchCategories()
    func fetchEvents()
}

final class ExplorePresenter: ExplorePresenterProtocol {

    // MARK: - Properties

    weak var view: ExploreViewProtocol?
    private let apiManager = APIManager.shared

    func fetchCategories() { }

    func fetchEvents() { }
}

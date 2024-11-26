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

    func fetchCategories() {
        apiManager.getEventCategories(lang: "ru") { [weak self] result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self?.view?.showCatigories(categories)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchEvents() { }
}

import UIKit

final class ExploreViewController: UIViewController {

    // MARK: - Properties

    var presenter: ExplorePresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        presenter?.fetchCategories()
        presenter?.fetchEvents()
    }

    // MARK: - Setup

    private func setupView() { }

    private func setupHierarchy() { }

    private func setupLayout() { }
}

extension ExploreViewController: ExploreViewProtocol {
    func showCatigories(_ categories: [EventCategoryModel]) { }

    func showEvents(_ events: [EventModel]) { }
}

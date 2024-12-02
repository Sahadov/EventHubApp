import UIKit

final class ModuleBuilder {
    static func createExploreModule() -> UIViewController {
        let view = ExploreViewController()
        let presenter = ExplorePresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
    static func createDetailModule(event: EventModel) -> UIViewController {
        let view = EventDetailsVC()
        let presenter = EventDetailsPresenter()
        view.presenter = presenter
        presenter.eventModel = event
        presenter.view = view
        return view
    }
}

import UIKit

final class ModuleBuilder {
    static func createExploreModule() -> UIViewController {
        let view = ExploreViewController()
        let presenter = ExplorePresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}

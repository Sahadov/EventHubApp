import UIKit

final class CategoryCollectionView: UIView {

    // MARK: - Properties

    private var categiries = [EventCategoryModel]()

    // MARK: - Initial

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() { }

    private func setupHierarchy() { }

    private func setupLayout() { }

    // MARK: - Configuration

    func configuration(with categories: [EventCategoryModel]) {
        self.categiries = categories
    }
}

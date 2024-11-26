import UIKit

final class EventHeaderCell: UICollectionReusableView {

    // MARK: - Properties

    static let identifier: String = "EventHeaderCell"

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
}

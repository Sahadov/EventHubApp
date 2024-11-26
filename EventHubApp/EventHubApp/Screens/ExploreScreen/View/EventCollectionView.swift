import UIKit

final class EventCollectionView: UIView {

    // MARK: - Properties

    private var events = [EventModel]()

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

    func configuration(with events: [EventModel]) {
        self.events = events
    }
}

import UIKit

final class EventHeaderCell: UICollectionReusableView {

    // MARK: - Properties

    static let identifier: String = "EventHeaderCell"

    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.airbnbFont(ofSize: 14, weight: .book)
        button.addAction(
            UIAction { [weak self] _ in self?.handleSeeAllButton() },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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

    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(seeAllButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            titleLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            seeAllButton.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            seeAllButton.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
        ])
    }

    // MARK: - Configuration

    func configuration(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Action

private extension EventHeaderCell {
    func handleSeeAllButton() { }
}

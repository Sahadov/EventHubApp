import UIKit

class LoaderCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier: String = "LoaderCell"

    // MARK: - UI

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Initial

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MAKR: - Setup

    private func setupUI() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
}


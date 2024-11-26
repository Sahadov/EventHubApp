import UIKit

final class ExploreViewController: UIViewController {

    // MARK: - Properties

    var presenter: ExplorePresenterProtocol?

    // MARK: - UI

    private let headerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.blue
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let currentLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Current location"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.alpha = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "New Yourk, USA"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(red: 0.957, green: 0.957, blue: 0.996, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        let arrowImage = UIImage(systemName: "arrowtriangle.down.fill")
        button.setImage(arrowImage, for: .normal)
        button.tintColor = UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)
        button.addAction(UIAction { [weak self] _ in self?.handleLocationButton() }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var notificationButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "bell")
        button.setImage(image, for: .normal)
        button.backgroundColor = AppColors.indigo
        button.tintColor = .white
        button.layer.cornerRadius = 18
        button.addAction(UIAction { [weak self] _ in self?.handleNotificationButton() }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var categoryCollectionView: CategoryCollectionView = {
        let view = CategoryCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var eventCollectionView: EventCollectionView = {
        let view = EventCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

    private func setupHierarchy() {
        [
            currentLocationLabel,
            locationButton,
            locationLabel,
            notificationButton,
        ].forEach { headerBackgroundView.addSubview($0) }

        [
            headerBackgroundView,
            categoryCollectionView,
            eventCollectionView,
        ].forEach { view.addSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            headerBackgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            headerBackgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            headerBackgroundView.heightAnchor.constraint(
                equalToConstant: 179
            ),
            currentLocationLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            currentLocationLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 17
            ),
            locationButton.centerYAnchor.constraint(
                equalTo: currentLocationLabel.centerYAnchor
            ),
            locationButton.leadingAnchor.constraint(
                equalTo: currentLocationLabel.trailingAnchor,
                constant: 5
            ),
            locationButton.heightAnchor.constraint(
                equalToConstant: 5
            ),
            locationButton.widthAnchor.constraint(
                equalToConstant: 10
            ),
            locationLabel.topAnchor.constraint(
                equalTo: currentLocationLabel.bottomAnchor,
                constant: 3
            ),
            locationLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 17
            ),
            notificationButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            notificationButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -22
            ),
            notificationButton.heightAnchor.constraint(
                equalToConstant: 36
            ),
            notificationButton.heightAnchor.constraint(
                equalToConstant: 36
            ),
            notificationButton.widthAnchor.constraint(
                equalToConstant: 36
            ),
            categoryCollectionView.centerYAnchor.constraint(
                equalTo: headerBackgroundView.bottomAnchor
            ),
            categoryCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            categoryCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            categoryCollectionView.heightAnchor.constraint(
                equalToConstant: 40
            ),
            eventCollectionView.topAnchor.constraint(
                equalTo: categoryCollectionView.bottomAnchor,
                constant: 20
            ),
            eventCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            eventCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            eventCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }
}

// MARK: - ExploreViewProtocol

extension ExploreViewController: ExploreViewProtocol {
    func showCatigories(_ categories: [EventCategoryModel]) {
        categoryCollectionView.configuration(with: categories)
    }

    func showEvents(_ events: [EventModel]) {
        eventCollectionView.configuration(with: events)
    }
}

// MARK: - Action

private extension ExploreViewController {
    func handleLocationButton() { }

    func handleNotificationButton() { }
}

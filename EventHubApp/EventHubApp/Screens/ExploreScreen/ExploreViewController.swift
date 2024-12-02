import UIKit

final class ExploreViewController: UIViewController {

    // MARK: - Properties

    var presenter: ExplorePresenterProtocol?
    private var cities = [LocationModel]()
    private var isCityPickerVisible = false
    private var isNearbyEventsFetched = false
    private let radiusEvents = 500

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
        button.addAction(
            UIAction { [weak self] _ in self?.handleLocationButton() },
            for: .touchUpInside
        )
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
        button.addAction(
            UIAction { [weak self] _ in self?.handleNotificationButton() },
            for: .touchUpInside
        )
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

    private lazy var cityPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = UIColor.white
        picker.layer.borderWidth = 1
        picker.layer.borderColor = AppColors.primaryBlue.cgColor
        picker.layer.cornerRadius = 10
        picker.layer.shadowColor = UIColor.black.cgColor
        picker.layer.shadowOpacity = 0.1
        picker.layer.shadowOffset = CGSize(width: 0, height: 5)
        picker.layer.shadowRadius = 5
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isHidden = true
        return picker
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        presenter?.fetchCities()
        presenter?.fetchCategories()
        presenter?.fetchUpcomingEvents()
        eventCollectionView.setDelegate(vc:self)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavouriteUpdate),
            name: Notification.Name("isFavoriteChanged"),
            object: nil
        )
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
            cityPickerView
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
            ),
            cityPickerView.topAnchor.constraint(
                equalTo: locationLabel.bottomAnchor,
                constant: 5
            ),
            cityPickerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 17
            ),
            cityPickerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -17
            ),
            cityPickerView.heightAnchor.constraint(
                equalToConstant: 100
            )
        ])
    }
}

// MARK: - ExploreViewProtocol

extension ExploreViewController: ExploreViewProtocol {
    func showCatigories(_ categories: [EventCategoryModel]) {
        categoryCollectionView.configuration(with: categories)
    }

    func showUpcomingEvents(_ events: [EventModel]) {
        eventCollectionView.configurationCurrent(with: events)
    }

    func showNearbyEvents(_ events: [EventModel]) {
        eventCollectionView.configurationNearby(with: events)
    }

    func showCities(_ cities: [LocationModel]) {
        self.cities = cities
        cityPickerView.reloadAllComponents()

        if !cities.isEmpty {
            cityPickerView.selectRow(0, inComponent: 0, animated: true)
            locationLabel.text = cities[0].name

            if !isNearbyEventsFetched {
                presenter?.fetchNearbyEvents(
                    lat: cities[0].coords?.lat ?? 0,
                    lon: cities[0].coords?.lon ?? 0,
                    radius: radiusEvents
                )
                isNearbyEventsFetched = true
            }
        }
    }
}

// MARK: - Action

private extension ExploreViewController {
    func handleLocationButton() {
        isCityPickerVisible.toggle()
        UIView.animate(withDuration: 0.3) {
            self.cityPickerView.isHidden = !self.isCityPickerVisible
            self.cityPickerView.alpha = self.isCityPickerVisible ? 1.0 : 0.0
        }
    }

    @objc func handleFavouriteUpdate() {
        eventCollectionView.reloadData()
    }

    func handleNotificationButton() { }
}

extension ExploreViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
}

extension ExploreViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationLabel.text = cities[row].name
        presenter?.fetchNearbyEvents(
            lat: cities[row].coords?.lat ?? 0,
            lon: cities[row].coords?.lon ?? 0,
            radius: radiusEvents
        )
        handleLocationButton()
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    func showDetail(_ event: EventModel) {
            let eventDetailVC = ModuleBuilder.createDetailModule(event: event)
           navigationController?.pushViewController(eventDetailVC, animated: true)
        }
}
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let sectionIndex = indexPath.section

        switch sectionIndex {
        case 0:
            let currentEvent = eventCollectionView.currentEvents[indexPath.row]
            presenter?.didTapEvent(event: currentEvent)
            print(currentEvent)
        case 1:
            let nearbyEvent = eventCollectionView.nearbyEvents[indexPath.row]
            presenter?.didTapEvent(event: nearbyEvent)
            print(nearbyEvent)
        default:
            break
        }
    }
} 

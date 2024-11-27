import UIKit

final class EventCollectionView: UIView {

    // MARK: - Properties

    private var currentEvents = [EventModel]()
    private var nearbyEvents = [EventModel]()

    private var currentEventsLoading: Bool = true
    private var nearbyEventsLoading: Bool = true

    // MARK: - UI

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayoutCollectionView()
        )
        collectionView.register(
            LoaderCell.self,
            forCellWithReuseIdentifier: LoaderCell.identifier
        )
        collectionView.register(
            EventCell.self,
            forCellWithReuseIdentifier: EventCell.identifier
        )
        collectionView.register(
            EventHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EventHeaderCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        addSubview(collectionView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }


    // MARK: - Configuration

    func configurationCurrent(with currentEvents: [EventModel]) {
        self.currentEvents = currentEvents
        currentEventsLoading = false
        collectionView.reloadSections(IndexSet(integer: 0))
    }

    func configurationNearby(with nearbyEvents: [EventModel]) {
        self.nearbyEvents = nearbyEvents
        nearbyEventsLoading = false
        collectionView.reloadSections(IndexSet(integer: 1))
    }
}

// MARK: - DataSource

extension EventCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return currentEventsLoading ? 1 : currentEvents.count
        case 1:
            return nearbyEventsLoading ? 1 : nearbyEvents.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Показываем ячейку с лоадером пока данные не загружены
        if (indexPath.section == 0 && currentEventsLoading) ||
            (indexPath.section == 1 && nearbyEventsLoading) {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LoaderCell.identifier,
                for: indexPath
            ) as? LoaderCell else {
                return UICollectionViewCell()
            }
            return cell
        }

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCell.identifier,
            for: indexPath
        ) as? EventCell else {
            return UICollectionViewCell()
        }

        var model: EventModel
        switch indexPath.section {
        case 0:
            model = currentEvents[indexPath.item]
        case 1:
            model = nearbyEvents[indexPath.item]
        default:
            return UICollectionViewCell()
        }

        cell.configuration(with: model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: EventHeaderCell.identifier,
            for: indexPath
        ) as? EventHeaderCell else {
            return UICollectionReusableView()
        }

        var headerTitle: String
        switch indexPath.section {
        case 0:
            headerTitle = "Upcoming Events"
        case 1:
            headerTitle = "Nearby Events"
        default:
            return UICollectionReusableView()
        }

        header.configuration(with: headerTitle)
        return header
    }
}

// MARK: - Delegate

extension EventCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - Layout Collection View

extension EventCollectionView {
    private func createLayoutCollectionView() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            switch section {
            default:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.7),
                    heightDimension: .estimated(255)
                )

                let layoutGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [layoutItem]
                )
                layoutGroup.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)

                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging

                let layoutSectionHeaderSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(50)
                )
                let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: layoutSectionHeaderSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

                layoutSection.contentInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)

                return layoutSection
            }
        }
    }
}

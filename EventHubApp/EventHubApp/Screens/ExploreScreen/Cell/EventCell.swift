import UIKit

final class EventCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier: String = "EventCell"
    private var isFavorite: Bool = false

    // MARK: - UI

    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = AppColors.gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        label.textColor = AppColors.red
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.layer.cornerRadius = 8
        label.layer.opacity = 0.8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var favouriteButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "bookmark")
        button.setImage(image, for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.tintColor = AppColors.red
        button.backgroundColor = .white
        button.layer.opacity = 0.8
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addAction(
            UIAction { [weak self] _ in self?.handleFavoriteButton() },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var participantsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = -8
        stackView.alignment = .center
        stackView.semanticContentAttribute = .forceRightToLeft
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var participantsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = AppColors.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "mapTabBar")
        imageView.image = image
        imageView.tintColor = AppColors.gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.airbnbFont(ofSize: 13, weight: .book)
        label.textAlignment = .left
        label.textColor = AppColors.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
    }

    private func setupHierarchy() {
        eventImageView.addSubview(dateLabel)
        eventImageView.addSubview(favouriteButton)

        addSubview(eventImageView)
        addSubview(titleLabel)
        addSubview(participantsStackView)
        addSubview(participantsLabel)
        addSubview(locationIcon)
        addSubview(locationLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 9
            ),
            eventImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 9
            ),
            eventImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -9
            ),
            eventImageView.heightAnchor.constraint(
                equalToConstant: 131
            ),
            dateLabel.topAnchor.constraint(
                equalTo: eventImageView.topAnchor,
                constant: 17
            ),
            dateLabel.leadingAnchor.constraint(
                equalTo: eventImageView.leadingAnchor,
                constant: 17
            ),
            dateLabel.heightAnchor.constraint(
                equalToConstant: 45
            ),
            dateLabel.widthAnchor.constraint(
                equalToConstant: 45
            ),
            favouriteButton.topAnchor.constraint(
                equalTo: eventImageView.topAnchor,
                constant: 17
            ),
            favouriteButton.trailingAnchor.constraint(
                equalTo: eventImageView.trailingAnchor,
                constant: -17
            ),
            favouriteButton.heightAnchor.constraint(
                equalToConstant: 30
            ),
            favouriteButton.widthAnchor.constraint(
                equalToConstant: 30),
            titleLabel.topAnchor.constraint(
                equalTo: eventImageView.bottomAnchor,
                constant: 14
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -14
            ),
            participantsStackView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 12
            ),
            participantsStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            participantsLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 12
            ),
            participantsLabel.leadingAnchor.constraint(
                equalTo: participantsStackView.trailingAnchor,
                constant: 10
            ),
            participantsLabel.heightAnchor.constraint(
                equalToConstant: 24
            ),
            locationIcon.topAnchor.constraint(
                equalTo: participantsLabel.bottomAnchor,
                constant: 10
            ),
            locationIcon.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            locationIcon.heightAnchor.constraint(
                equalToConstant: 16
            ),
            locationIcon.widthAnchor.constraint(
                equalToConstant: 16
            ),
            locationLabel.centerYAnchor.constraint(
                equalTo: locationIcon.centerYAnchor
            ),
            locationLabel.leadingAnchor.constraint(
                equalTo: locationIcon.trailingAnchor,
                constant: 1
            ),
            locationLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
        ])
    }

    // MARK: - Configuration

    func configuration(with events: EventModel) {

        if let imageStringURL = events.images?.first?.image,
           let imageURL = URL(string: imageStringURL) {
            NetworkManager.shared.fetchImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.eventImageView.image = UIImage(data: data)
                    }
                case .failure(let error):
                    print("Failed to fetch image: \(error.localizedDescription)")
                }
            }
        }

        dateLabel.text = formatDate(from: events.dates?.first?.start ?? 0).uppercased()
        titleLabel.text = events.shortTitle
        locationLabel.text = events.place?.address
        participantsLabel.text = "+0 Going" //TODO: Получать кол-во участников

        let images = [
            UIImage(named: "goingThree"),
            UIImage(named: "goingTwo"),
            UIImage(named: "goingOne"),
        ]
        configurationParticipants(avatars: images)
    }

    private func createAvatarImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        return imageView
    }

    private func configurationParticipants(avatars: [UIImage?]) {
        participantsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        avatars.forEach { avatar in
            let imageView = createAvatarImageView(image: avatar)
            participantsStackView.addArrangedSubview(imageView)
        }
    }

    private func formatDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd\nMMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }

    override func prepareForReuse() {
        eventImageView.image = nil
        dateLabel.text = nil
        titleLabel.text = nil
        locationLabel.text = nil
        participantsLabel.text = nil
    }
}

// MARK: - Action

private extension EventCell {
    func handleFavoriteButton() {
        isFavorite.toggle()
        let imageView = isFavorite ? "bookmark.fill" : "bookmark"
        favouriteButton.setImage(UIImage(systemName: imageView), for: .normal)
    }
}

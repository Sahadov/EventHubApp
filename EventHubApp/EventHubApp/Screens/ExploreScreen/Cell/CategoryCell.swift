import UIKit

final class CategoryCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier: String = "CategoryCell"

    // MARK: - UI

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.airbnbFont(ofSize: 15, weight: .book)
        label.textColor = .white
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
        layer.masksToBounds = true
        layer.cornerRadius = 21
        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
    }

    private func setupHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            imageView.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            imageView.heightAnchor.constraint(
                equalToConstant: 18
            ),
            imageView.widthAnchor.constraint(
                equalToConstant: 18
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: 8
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16),
            titleLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
        ])
    }

    // MARK: - Configuration

    func configuration(with category: EventCategoryModel, isSelected: Bool) {
        titleLabel.text = category.name?.components(separatedBy: " ").first
        let image = CategoryConfigurator.iconName(forSlug: category.slug)
        imageView.image = UIImage(systemName: image)

        backgroundColor = CategoryConfigurator.color(forSlug: category.slug)
        self.backgroundColor = backgroundColor

        // Если выделена, добавляем тень и изменяем фон
        if isSelected {
            layer.borderColor = UIColor.white.cgColor
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 8)
            layer.shadowOpacity = 0.9
            layer.shadowRadius = 10
            transform = CGAffineTransform(scaleX: 1.05, y: 1.05)

            self.backgroundColor = backgroundColor?.withAlphaComponent(0.9)
        } else {
            layer.borderColor = UIColor.clear.cgColor
            layer.shadowOpacity = 0
            transform = .identity

            self.backgroundColor = backgroundColor
        }

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        layer.shadowOpacity = 0
        transform = .identity
    }
}

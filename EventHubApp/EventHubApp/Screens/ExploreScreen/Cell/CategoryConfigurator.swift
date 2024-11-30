import UIKit

final class CategoryConfigurator {
    static let iconCategoryDictionary: [String: String] = [
        "business-events": "briefcase.fill",
        "cinema": "film.fill",
        "concert": "music.note",
        "education": "book.fill",
        "entertainment": "gamecontroller.fill",
        "exhibition": "rectangle.3.offgrid.fill",
        "fashion": "tshirt.fill",
        "festival": "star.fill",
        "holiday": "airplane",
        "kids": "teddybear.fill",
        "other": "questionmark.circle.fill",
        "party": "party.popper.fill",
        "photo": "camera.fill",
        "quest": "map.fill",
        "recreation": "sportscourt.fill",
        "shopping": "cart.fill",
        "social-activity": "bubble.left.and.bubble.right.fill",
        "stock": "chart.bar.xaxis.fill",
        "theater": "theatermasks.fill",
        "tour": "mappin.and.ellipse",
        "yarmarki-razvlecheniya-yarmarki": "gift.fill"
    ]

    static let colorCategoryDictionary: [String: UIColor] = [
        "business-events": AppColors.red,
        "cinema": AppColors.orange,
        "concert": AppColors.green,
        "education": AppColors.lightBlue,
        "entertainment": AppColors.red,
        "exhibition": AppColors.orange,
        "fashion": AppColors.green,
        "festival": AppColors.lightBlue,
        "holiday": AppColors.red,
        "kids": AppColors.orange,
        "other": AppColors.green,
        "party": AppColors.lightBlue,
        "photo": AppColors.red,
        "quest": AppColors.orange,
        "recreation": AppColors.green,
        "shopping": AppColors.lightBlue,
        "social-activity": AppColors.red,
        "stock": AppColors.orange,
        "theater": AppColors.green,
        "tour": AppColors.lightBlue,
        "yarmarki-razvlecheniya-yarmarki": AppColors.red
    ]

    static func iconName(forSlug slug: String?) -> String {
        guard let slug = slug, let iconName = iconCategoryDictionary[slug] else {
            return "questionmark.circle.fill"
        }
        return iconName
    }

    static func color(forSlug slug: String?) -> UIColor {
        guard let slug = slug, let color = colorCategoryDictionary[slug] else {
            return AppColors.gray
        }
        return color
    }
}

//
//  CustomTarBar.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 18.11.2024.
//

import UIKit


private enum Constants {
    static let favouriteButtonOffset: CGFloat = -10
    static let favouriteButtonSizeMultiplier: CGFloat = 0.65
    static let topOffset: CGFloat = -8
}


final class CustomTabBar: UITabBar {

    //MARK: Properties
    var onFavouriteButtonTap: (() -> Void)?
    let favouriteButton = FavouriteButton(type: .system)

    //MARK: TabBar View Settings
    override func draw(_ rect: CGRect) {
        configureShape()
    }

    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
        setupFavouriteButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: Configure
    private func setupTabBar() {
        tintColor = AppColors.blue
    }

    private func setupFavouriteButton(){
        addSubview(favouriteButton)
        NSLayoutConstraint.activate([
            favouriteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            favouriteButton.centerYAnchor.constraint(equalTo: topAnchor, constant: Constants.favouriteButtonOffset),
            favouriteButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.favouriteButtonSizeMultiplier),
            favouriteButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.favouriteButtonSizeMultiplier)
        ])

        favouriteButton.onTap = { [weak self] in
                guard let tabBarController = self?.window?.rootViewController as? UITabBarController else { return }
                tabBarController.selectedIndex = 2
        }
        
        
    }

    //MARK: Hit test
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        favouriteButton.frame.contains(point) ? favouriteButton : super.hitTest(point, with: event)
    }
}

//MARK: - Draw Shape
extension CustomTabBar {
    private func configureShape() {
        let path = createTabBarPath()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        layer.insertSublayer(shape, at: 0)
        layer.shadowColor = AppColors.blue.cgColor
        layer.shadowOpacity = 0.1
    }
    private func createTabBarPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: Constants.topOffset))
        path.addLine(to: CGPoint(x: frame.width, y: Constants.topOffset))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        return path
    }
}


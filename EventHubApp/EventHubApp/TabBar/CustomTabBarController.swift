//
//  CustomTabBarController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 18.11.2024.
//

import UIKit




class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    private let customTabBar = CustomTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar")
        delegate = self // Set the tab bar controller delegate

        setupTabItems()
    }
    
    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is FavouritesViewController {
            customTabBar.favouriteButton.updateBackgroundColor(to: AppColors.orange)
        } else {
            customTabBar.favouriteButton.updateBackgroundColor(to: AppColors.blue)
        }
    }
    
    private func setupTabItems(){
        let exploreVC = ModuleBuilder.createExploreModule()
        exploreVC.tabBarItem.title = "Explore"
        exploreVC.tabBarItem.image = UIImage(named: "compassTabBar")

        let eventsVC = EventDetailsVC()
        eventsVC.tabBarItem.title = "Events"
        eventsVC.tabBarItem.image = UIImage(named: "calendarTabBar")

        let mapVC = ViewController()
        mapVC.tabBarItem.title = "Map"
        mapVC.tabBarItem.image = UIImage(named: "mapTabBar")

        let profileVC = ProfileViewController()
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "profileTabBar")
        
        let favouritesVC = FavouritesViewController(viewOutput: FavouritesPresenter())
    
        setViewControllers(
            [
                exploreVC,
                UINavigationController(rootViewController: eventsVC),
                favouritesVC,
                mapVC,
                UINavigationController(rootViewController: profileVC)
            ],
            animated: true
        )
    }

}





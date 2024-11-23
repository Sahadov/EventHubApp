//
//  CustomTabBarController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 18.11.2024.
//

import UIKit




class CustomTabBarController: UITabBarController {
    private var callback: Callback?
    private let customTabBar = CustomTabBar()

    init(callback: Callback? = nil) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar")
        setupTabItems()
    }

    private func setupTabItems(){
        let exploreVC = ViewController()
        exploreVC.tabBarItem.title = "Explore"
        exploreVC.tabBarItem.image = UIImage(named: "compassTabBar")

        let eventsVC = ViewController()
        eventsVC.tabBarItem.title = "Events"
        eventsVC.tabBarItem.image = UIImage(named: "calendarTabBar")

        let mapVC = ViewController()
        mapVC.tabBarItem.title = "Map"
        mapVC.tabBarItem.image = UIImage(named: "mapTabBar")

        let profileVC = ProfileViewController()
        profileVC.callback = callback
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "profileTabBar")
        
        let favouritesVC = FavouritesViewController(viewOtput: FavouritesPresenter())
    
        setViewControllers(
            [
                exploreVC,
                eventsVC,
                favouritesVC,
                mapVC,
                UINavigationController(rootViewController: profileVC)
            ],
            animated: true
        )
    }

}





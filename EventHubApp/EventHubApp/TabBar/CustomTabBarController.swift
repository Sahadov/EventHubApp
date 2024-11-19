//
//  CustomTabBarController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 18.11.2024.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar")
        setupTabItems()
    }
    
    private func setupTabItems(){
        let firstVC = ViewController()
        firstVC.tabBarItem.title = "Explore"
        firstVC.tabBarItem.image = UIImage(named: "compassTabBar")
        
        let secondVC = ViewController()
        secondVC.tabBarItem.title = "Events"
        secondVC.tabBarItem.image = UIImage(named: "calendarTabBar")
        
        let thirdVC = ViewController()
        thirdVC.tabBarItem.title = "Map"
        thirdVC.tabBarItem.image = UIImage(named: "mapTabBar")
        
        let fourthVC = ProfileViewController()
        fourthVC.tabBarItem.title = "Profile"
        fourthVC.tabBarItem.image = UIImage(named: "profileTabBar")
        
        setViewControllers(
            [
                firstVC,
                secondVC,
                thirdVC,
                UINavigationController(rootViewController: fourthVC)
            ],
            animated: true
        )
    }
    
}


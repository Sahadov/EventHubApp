//
//  SceneDelegate.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 17.11.2024.
//

import UIKit
import SwiftUI
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        start()
    }
    
    func start() {
        if Auth.auth().currentUser == nil {
            setRootViewController(makeAuth())
        } else {
            setRootViewController(makeTabbar())
        }
    }

    func setRootViewController(_ controller: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = controller
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }

    private func makeAuth() -> UIViewController {
        let callback: Callback = { [weak self] in
            self?.start()
        }
        let controller = SignInViewController()
        controller.callback = callback
        return UINavigationController(rootViewController: controller)
    }

    private func makeTabbar() -> UIViewController {
        let callback: Callback = { [weak self] in
            self?.start()
            
        }
        return CustomTabBarController(callback: callback)
    }

}


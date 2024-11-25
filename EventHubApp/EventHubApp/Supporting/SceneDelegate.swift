//
//  SceneDelegate.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 17.11.2024.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = OnboardingViewController(presenter: OnboardingViewPresenterImpl())
        window?.makeKeyAndVisible()
        Task {
            do {
                let response: EventResponse = try await APIClient.shared.request(.getNews(NewsRequest(location: "spb")))
                response.results.forEach { print($0.title) }
            } catch {
                print(error)
            }
        }
    }
    
}


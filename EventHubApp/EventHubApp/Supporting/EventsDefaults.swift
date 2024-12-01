//
//  EventsDefaults.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 01.12.2024.
//

import Foundation

struct EventsDefaults {
    static var isOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: "isOnboarding") }
        set { UserDefaults.standard.set(newValue, forKey: "isOnboarding") }
    }
}

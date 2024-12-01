//
//  Person.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 01.12.2024.
//

import Foundation
import FirebaseAuth

struct Person: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    let email: String
    var about = ""
    var pushId = ""
    var avatarLink = ""
    var fullname = ""
    var status = Status()
    var initials: String {
        String(username.first ?? "?")
    }
}

extension Person {
    static var currentId: String {
        Auth.auth().currentUser?.uid ?? ""
    }

    static var currentName: String {
        "Current Name"
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    static func chatRoomIdFrom(id: String) -> String {
        let value = id.compare(currentId).rawValue
        return value < 0 ? id + currentId : currentId + id
    }

}

extension Person {
    struct Status: Codable, Hashable {
        var index = 0
        var statuses = ["Available", "Busy", "At School"]
        var text: String {
            index < statuses.count ? statuses[index] : "No status"
        }
    }
}

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
}

//
//  ProfileStore.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 23.11.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum ProfileEvent {
    case done(Person)
    case signOut
}

enum ProfileAction {
    case fetch
    case signOut
}

final class ProfileStore: Store<ProfileEvent, ProfileAction> {
    override func handleActions(action: ProfileAction) {
        switch action {
        case .fetch:
            statefulCall { [weak self] in
                try await self?.fetchPerson()
            }
        case .signOut:
            statefulCall { [weak self] in
                try self?.signOut()
            }
        }
    }

    private func signOut() throws {
        try Auth.auth().signOut()
        sendEvent(.signOut)
    }

    private func fetchPerson() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let querySnapshot = try await Firestore
            .firestore()
            .collection("persons")
            .document(uid)
            .getDocument()
        if let person = try? querySnapshot.data(as: Person.self) {
            sendEvent(.done(person))
        }
    }
}

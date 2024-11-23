//
//  EditProfileStore.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 23.11.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

enum EditProfileEvent {
    case done(Person)
}

enum EditProfileAction {
    case updateUsername(String)
    case uploadImage(UIImage)
    case updateAvatarLink(String)
    case fetch
}

final class EditProfileStore: Store<EditProfileEvent, EditProfileAction> {

    override func handleActions(action: EditProfileAction) {
        switch action {
        case .updateUsername(let username):
            statefulCall { [weak self] in
                try self?.updateUsername(username)
            }
        case .uploadImage(let image):
            statefulCall { [weak self] in
                try await self?.uploadImage(image)
            }
        case .updateAvatarLink(let link):
            statefulCall { [weak self] in
                try self?.updateAvatarLink(link)
            }
        case .fetch:
            statefulCall { [weak self] in
                try await self?.fetchPerson()
            }
        }
    }

    private func updateAvatarLink(_ link: String) throws {
//        try useCase.updateAvatar(link)
    }

    private func updateUsername(_ username: String) throws {
//        try useCase.updateUsername(username)
    }

    private func uploadImage(_ image: UIImage) async throws {
//        if let url = try await useCase.uploadImage(image) {
//            try useCase.updateAvatar(url)
//        }
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

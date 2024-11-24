//
//  EditProfileStore.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 23.11.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

enum EditProfileEvent {
    case done(Person)
}

enum EditProfileAction {
    case updateUsername(String)
    case uploadImage(UIImage)
    case upload(Person)
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
        case .fetch:
            statefulCall { [weak self] in
                try await self?.fetchPerson()
            }
        case .upload(let person):
            statefulCall { [weak self] in
                try self?.upload(person)
            }
        }
    }
    
    private func upload(_ person: Person) throws {
        try Firestore
            .firestore()
            .collection("persons")
            .document(person.id)
            .setData(from: person)
    }

    private func updateAvatarLink(_ link: String, uid: String) {
        Firestore
            .firestore()
            .collection("persons")
            .document(uid)
            .updateData(["avatarLink": link])
    }

    private func updateUsername(_ username: String) throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore
            .firestore()
            .collection("persons")
            .document(uid)
            .updateData(["username": username])
    }

    private func uploadImage(_ image: UIImage) async throws {
        guard let uid = Auth.auth().currentUser?.uid,
              let data = image.jpegData(compressionQuality: 0.7)
        else { return }
        let directory = "/profile/\(uid).jpg"
        let storageRef = Storage.storage()
            .reference()
            .child(directory)
        let _ = try await storageRef.putDataAsync(data)
        let url = try await storageRef.downloadURL()
        updateAvatarLink(url.absoluteString, uid: uid)
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

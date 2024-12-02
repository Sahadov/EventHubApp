//
//  AuthStore.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 23.11.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthEvent {
    case login
}

enum AuthAction {
    case createUser(String, String, String)
    case signIn(String, String)
    case sendPasswordReset(String)
    case sendEmail(String)
    case googleSignIn(String, String)
}

final class AuthStore: Store<AuthEvent, AuthAction> {
    override func handleActions(action: AuthAction) {
        switch action {
        case .createUser(let email, let password, let name):
            statefulCall { [weak self] in
                try await self?.register(withEmail: email, password: password, name: name)
            }
        case .signIn(let email, let password):
            statefulCall { [weak self] in
                try await self?.signIn(withEmail: email, password: password)
            }
        case .sendPasswordReset(let email):
            statefulCall { [weak self] in
                try await self?.sendPasswordReset(withEmail: email)
            }
        case .sendEmail(let email):
            statefulCall { [weak self] in
                try await self?.sendEmail(email)
            }
        case .googleSignIn(let idToken, let accessToken):
            statefulCall { [weak self] in
                try await self?.googleSignIn(idToken, accessToken)
            }
        }
    }

    private func googleSignIn(_ idToken: String, _ accessToken: String) async throws {
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: accessToken
        )
        let authResult = try await Auth.auth().signIn(with: credential)
        if let isNewUser = authResult.additionalUserInfo?.isNewUser, isNewUser {
            let uid = authResult.user.uid
            let name = authResult.user.displayName ?? ""
            let email = authResult.user.email ?? ""
            let person = Person(id: uid, username: name, email: email)
            print("User created: \(person)")
            try await Firestore.firestore()
                .collection("persons")
                .document(uid)
                .setData(["id": uid,
                          "username": name,
                          "email": email,
                          "about": "",
                          "avatarLink": "",
                          "fullName": name])
        }
        sendEvent(.login)
    }
    
    private func sendEmail(_ email: String) async throws {
    }

    private func register(withEmail email: String, password: String, name: String) async throws {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        try await authResult.user.sendEmailVerification()
        let uid = authResult.user.uid
        let person = Person(id: uid, username: name, email: email)
        print("User created: \(person)")
        try await Firestore.firestore()
            .collection("persons")
            .document(uid)
            .setData(["id": uid,
                      "username": name,
                      "email": email,
                      "about": "",
                      "avatarLink": "",
                      "fullName": name])
        sendEvent(.login)
    }

    private func signIn(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        sendEvent(.login)
        if result.user.isEmailVerified {
            print("User is verified")
        }
    }

    private func sendPasswordReset(withEmail email: String) async throws {
    }
}

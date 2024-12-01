//
//  AuthStore.swift
//  EventHubApp
//
//  Created by Vladimir Fibe on 23.11.2024.
//

import Foundation
import FirebaseAuth

enum AuthEvent {
    case login
}

enum AuthAction {
    case createUser(String, String, String)
    case signIn(String, String)
    case sendPasswordReset(String)
    case sendEmail(String)
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
        }
    }

    private func sendEmail(_ email: String) async throws {
    }

    private func register(withEmail email: String, password: String, name: String) async throws {
        print(name, password, email)
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

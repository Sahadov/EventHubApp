//
//  FavouritesPresenter.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 19.11.2024.
//

//static func makeLoginScene(coordinator: AppCoordinator) -> LoginViewController {
//      let presenter = LoginPresenter(coordinator: coordinator)
//      let controller = LoginViewController(viewOtput: presenter, state: .login)
//      return controller
//  }

import Foundation

protocol FavouritesViewOutput: AnyObject {
    func loginStart()
    func registrationStart()
    func goToFacebookLogin()
    func goToGoogleLogin()
    func goToSignIn()
    func goToSignUp()
    func goToForgotPass()
    func goBack()
}

class FavouritesPresenter {
    
    weak var viewInput: FavouritesViewInput?

    init(viewInput: FavouritesViewInput? = nil) {
        self.viewInput = viewInput
    }
}

extension FavouritesPresenter: FavouritesViewOutput {
    func loginStart() {
        
    }
    
    func registrationStart() {
        
    }
    
    func goToFacebookLogin() {
        
    }
    
    func goToGoogleLogin() {
        
    }
    
    func goToSignIn() {
        
    }
    
    func goToSignUp() {
        
    }
    
    func goToForgotPass() {
        
    }
    
    func goBack() {
        
    }
    
    
}


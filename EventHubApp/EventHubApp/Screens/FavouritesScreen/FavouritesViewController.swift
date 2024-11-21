//
//  FavouritesViewController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 19.11.2024.
//

import UIKit

protocol FavouritesViewInput: AnyObject {
    func onSignInTapped()
    func onSignUpTapped()
    func onFacebookTapped()
    func onGoogleTapped()
    func onForgotTapped()
    func onBackPressed()
}

class FavouritesViewController: UIViewController {

    // MARK: - Properties
    var viewOutput: FavouritesViewOutput!
    
    // MARK: - Views
    private lazy var titleLabel = UILabel()
    
    // MARK: - Initializers
    init(viewOtput: FavouritesViewOutput){
        super.init(nibName: nil, bundle: nil)
        self.viewOutput = viewOtput
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
    func facebookPressed(){
        print("Facebook pressed")
    }
    func googlePressed(){
        print("Google pressed")
    }

}

// MARK: - Layout
private extension FavouritesViewController {
    func setupLayout(){
        view.backgroundColor = .red
    }
}

// MARK: - LoginViewInput Delegate
extension FavouritesViewController: FavouritesViewInput {
    func onSignInTapped() {
        
    }
    
    func onSignUpTapped() {
    
    }
    
    func onFacebookTapped() {
        
    }
    
    func onGoogleTapped() {
        
    }
    
    func onForgotTapped() {
        
    }
    
    func onBackPressed() {
        
    }
    
}


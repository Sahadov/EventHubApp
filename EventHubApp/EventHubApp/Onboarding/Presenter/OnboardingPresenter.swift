//
//  Presenter.swift
//  EventHubApp
//
//  Created by Andrew Linkov on 18.11.2024.
//

import Foundation

protocol OnboardingViewDelegate: AnyObject {
    func updateUI()
    func scrollToNextSlide()
}

final class OnboardingViewPresenterImpl {
    
//MARK: - Properties
    weak var view: OnboardingViewDelegate?
    var callback: Callback?
}

//MARK: - OnboardingPresenterImpl + OnboardingViewPresenter
extension OnboardingViewPresenterImpl: OnboardingViewPresenter {

    func didTapNext() {
        callback?()
    }
    
}

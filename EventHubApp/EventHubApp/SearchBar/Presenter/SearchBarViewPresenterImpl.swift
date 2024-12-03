//
//  SearchBarViewPresenterImpl.swift
//  EventHubApp
//
//  Created by Andrew Linkov on 25.11.2024.
//

import Foundation

protocol SearchViewDelegate: AnyObject {
    
}

final class SearchBarViewPresenterImpl {
    
    //MARK: - Properties
    weak var view: SearchViewDelegate?
    private let apiManager = APIManager.shared

 
}

extension SearchBarViewPresenterImpl: SearchBarViewPresenter {
    
}


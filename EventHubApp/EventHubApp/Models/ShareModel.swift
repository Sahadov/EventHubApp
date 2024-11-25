//
//  ShareModel.swift
//  EventHubApp
//
//  Created by Кирилл Бахаровский on 11/24/24.
//

struct ButtonsShareModel {
    let title: String
    let imageNamed: String
    let urlApp: String?
    let idApp: String?
    
    init(title: String, imageNamed: String, urlApp: String? = nil, idApp: String? = nil) {
        self.title = title
        self.imageNamed = imageNamed
        self.urlApp = urlApp
        self.idApp = idApp
    }
}

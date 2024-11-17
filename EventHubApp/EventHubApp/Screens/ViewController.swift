//
//  ViewController.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 17.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var label: UILabel = {
        var element = UILabel()
        element.text = "Title"
        element.font = .airbnbFont(ofSize: 30, weight: .light)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    func setupViews(){
        view.backgroundColor = AppColors.blue
        view.addSubview(label)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}


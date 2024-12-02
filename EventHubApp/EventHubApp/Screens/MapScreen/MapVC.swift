//
//  MapVC.swift
//  EventHubApp
//
//  Created by Сергей Сухарев on 02.12.2024.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    let mapView = MKMapView()
    let buttonPlus = UIButton()
    let buttonMinus = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        configuration()
    }
    
    private func configuration() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let initialLocation = CLLocation(latitude: 55.7558, longitude: 37.6176)
        mapView.centerCoordinate = initialLocation.coordinate
        let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
        mapView.setRegion(region, animated: true)
        
        buttonPlus.translatesAutoresizingMaskIntoConstraints = false
        buttonPlus.setImage(UIImage(systemName: "plus.magnifyingglass"), for: .normal)
        buttonPlus.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        
        buttonMinus.translatesAutoresizingMaskIntoConstraints = false
        buttonMinus.setImage(UIImage(systemName: "minus.magnifyingglass"), for: .normal)
        buttonMinus.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
    }
    
    private func setupView() {
        view.addSubview(mapView)
        view.addSubview(buttonPlus)
        view.addSubview(buttonMinus)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            buttonPlus.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonPlus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            buttonMinus.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonMinus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func zoomIn() {
            // Увеличить масштаб карты
            let currentRegion = mapView.region
            let newRegion = MKCoordinateRegion(
                center: currentRegion.center,
                span: MKCoordinateSpan(latitudeDelta: currentRegion.span.latitudeDelta / 2, longitudeDelta: currentRegion.span.longitudeDelta / 2)
            )
            mapView.setRegion(newRegion, animated: true)
        }

    @objc private func zoomOut() {
            let currentRegion = mapView.region
            let newRegion = MKCoordinateRegion(
                center: currentRegion.center,
                span: MKCoordinateSpan(latitudeDelta: currentRegion.span.latitudeDelta * 2, longitudeDelta: currentRegion.span.longitudeDelta * 2)
            )
            mapView.setRegion(newRegion, animated: true)
        }

}

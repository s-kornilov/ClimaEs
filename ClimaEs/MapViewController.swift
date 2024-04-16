//
//  MapViewController.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 06/04/2024.
//

import Foundation
import UIKit
import MapKit


class BeachAnnotation: MKPointAnnotation {
    var beach: Beach?
}

final class MapViewController: UIViewController, MKMapViewDelegate {
    
    private lazy var mapView = MKMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
        setupMapView()
        configureMapView()
        addPins()
        setupZoomInButton()
        setupZoomOutButton()
    }
    
    private func setupMapView() {
        mapView.toAutoLayout()
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
    }
    
    private func configureMapView() {
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        //mapView.showsUserTrackingButton = true
        mapView.showsScale = true
        
        
        let center = CLLocationCoordinate2D(latitude: 36.57248, longitude: -4.5880723)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
        //            let center = CLLocationCoordinate2D(latitude: 36.588223, longitude: -4.5301228)
        //            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        //            let region = MKCoordinateRegion(center: center, span: span)
        //            self?.mapView.setRegion(region, animated: true)
        //        }
        
    }
    
    private func addPins() {
        for beach in beaches {
            let annotation = BeachAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: beach.latitude, longitude: beach.longitude)
            annotation.title = beach.beachName
            annotation.subtitle = "\(beach.cityName), \(beach.regionName)"
            annotation.beach = beach
            mapView.addAnnotation(annotation)
        }
    }
    
    func setupZoomInButton() {
        let zoomInButton = UIButton()
        zoomInButton.backgroundColor = .systemBlue
        zoomInButton.setTitle("+", for: .normal)
        zoomInButton.layer.cornerRadius = 30
        zoomInButton.addTarget(self, action: #selector(zoomInAction), for: .touchUpInside)
        view.addSubview(zoomInButton)
        
        zoomInButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-150)
            make.width.height.equalTo(60)
        }
    }
    
    func setupZoomOutButton() {
        let zoomOutButton = UIButton()
        zoomOutButton.backgroundColor = .systemBlue
        zoomOutButton.setTitle("-", for: .normal)
        zoomOutButton.layer.cornerRadius = 30
        zoomOutButton.addTarget(self, action: #selector(zoomOutAction), for: .touchUpInside)
        view.addSubview(zoomOutButton)
        
        zoomOutButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-80)
            make.width.height.equalTo(60)
        }
    }
    
    
    @objc func zoomInAction() {
        var region = mapView.region
        region.span.latitudeDelta /= 2.0
        region.span.longitudeDelta /= 2.0
        mapView.setRegion(region, animated: true)
    }
    
    @objc func zoomOutAction() {
        var region = mapView.region
        region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
        region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let beachAnnotation = view.annotation as? BeachAnnotation,
           let beach = beachAnnotation.beach {
            let alert = UIAlertController(title: "Añadir a favoritos", message: "¿Quieres añadir beach \(beach.beachName) a tus favoritos?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                // Añade la playa a favoritos
                BeachesStore.shared.addFavoriteBeach(beach)
                print("Playa \(beach.beachName) se añade a favoritos")
                
                // Envía una notificación cuando una nueva playa se añada a favoritos
                NotificationCenter.default.post(name: NSNotification.Name("BeachAdded"), object: beach)
                
                // Volver a la pantalla anterior
                self?.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func returnToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
    
}

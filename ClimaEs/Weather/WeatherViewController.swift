//
//  WeatherViewController.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 28/03/2024.
//

import UIKit
import SnapKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    let weatherView = WeatherView()
    let currentCityBar = CurrentCityBar()
    let currentCity = CurrentCity()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        setupBackground()
        setupViews()
        setupConstraint()
        setupNavigationBar()
        
    }
    
    
    
    private func setupViews() {
        view.addSubview(weatherView)
        view.addSubview(currentCityBar)
        view.addSubview(currentCity)
    }
    
    private func setupNavigationBar() {
        let currentCityBarItem = UIBarButtonItem(customView: currentCityBar)
        navigationItem.leftBarButtonItem = currentCityBarItem
        
        let currentCityBarIcon = UIImage(systemName: "list.dash") // Используйте свою иконку
        let currentCityBarRightButton = UIBarButtonItem(image: currentCityBarIcon, style: .plain, target: self, action: #selector(goToNextViewController))
        navigationItem.rightBarButtonItem = currentCityBarRightButton
        
    }
    
    
    private func setupConstraint() {
        currentCity.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        weatherView.snp.makeConstraints { make in
            make.top.equalTo(currentCity.snp.bottom).offset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func goToNextViewController() {
        let cityListVC = CityListViewController()
        navigationController?.pushViewController(cityListVC, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Location: \(location)")
        }
    }
    
    
}


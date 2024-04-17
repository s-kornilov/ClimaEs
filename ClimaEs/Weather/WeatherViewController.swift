//
//  WeatherViewController.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 28/03/2024.
//

import UIKit
import SnapKit
import CoreLocation

class WeatherViewController: UIViewController {
    let weatherView = WeatherView()
    let currentCityBar = CurrentCityBar()
    let currentCity = CurrentCityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupBackground()
        setupViews()
        setupConstraint()
        setupNavigationBar()
        
        LocationManager.shared.onLocationReceived = { [weak self] location in
                    self?.updateWeather(for: location)
                }
        LocationManager.shared.requestLocation()
    }
    
    private func setupViews() {
        view.addSubview(weatherView)
        view.addSubview(currentCityBar)
        view.addSubview(currentCity)
    }
    
    private func setupNavigationBar() {
        let currentCityBarItem = UIBarButtonItem(customView: currentCityBar)
        navigationItem.leftBarButtonItem = currentCityBarItem
        
        let currentCityBarIcon = UIImage(systemName: "list.dash")
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
    
    
    func updateWeather(for location: CLLocation) {
            print("Updating weather for coordinates: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
    
}


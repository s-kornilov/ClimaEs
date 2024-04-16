//
//  AppDelegate.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 28/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let weatherVC = WeatherViewController()
        weatherVC.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "thermometer.sun"), selectedImage: nil)
        
        let beachVC = BeachListViewController()
        beachVC.tabBarItem = UITabBarItem(title: "Beach", image: UIImage(systemName: "sun.haze"), selectedImage: nil)
        
//        let windVC = MapViewController()//WindViewController()
//        windVC.tabBarItem = UITabBarItem(title: "Wind", image: UIImage(systemName: "wind"), selectedImage: nil)

        let customTabBarController = CustomTabBarController()
        customTabBarController.viewControllers = [weatherVC, beachVC].map { UINavigationController(rootViewController: $0) }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = customTabBarController
        window!.makeKeyAndVisible()
        
        return true
    }
}

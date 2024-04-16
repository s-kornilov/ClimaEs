//
//  CustomTabBarController.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 04/04/2024.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

            let tabBarHeight: CGFloat = 60
            let bottomInset: CGFloat = 10
            let tabBarWidth = view.bounds.width - 40

            tabBar.frame = CGRect(
                x: 20,
                y: view.frame.size.height - tabBarHeight - bottomInset - view.safeAreaInsets.bottom,
                width: tabBarWidth,
                height: tabBarHeight
            )

            tabBar.layer.cornerRadius = 20
            tabBar.layer.masksToBounds = true

            tabBar.backgroundColor = .white
            tabBar.backgroundImage = UIImage()

    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
}

//
//  PMDTabBarController.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 8.09.2023.
//

import UIKit

class PMDTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbar()
    }
    
    func setUpTabbar(){
        let homeViewController = PMDHomeViewController()
        let settingsViewController = PMDSettingsViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        viewControllers = [homeViewController,settingsViewController]
        tabBar.backgroundColor = .systemGray.withAlphaComponent(0.5)
        tabBar.tintColor = .systemRed
        tabBar.unselectedItemTintColor = .white
    }
}

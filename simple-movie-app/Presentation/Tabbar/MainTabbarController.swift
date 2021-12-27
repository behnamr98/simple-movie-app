//
//  MainTabbarController.swift
//  test
//
//  Created by Partdp on 12/19/21.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let main = UINavigationController(
            rootViewController: MainViewController()
        )
        main.tabBarItem.tag = 0
        main.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
        let profile = UINavigationController(
            rootViewController: ProfileViewController()
        )
        profile.tabBarItem.tag = 0
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [main, profile]
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .white.withAlphaComponent(0.8)
        tabBar.backgroundColor = .darkerGaryBack
        tabBar.isTranslucent = false
        
    }
    
    
}

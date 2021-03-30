//
//  TabBarController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit


class TabBarController: UITabBarController {
    
    let showsNavigationController: UINavigationController
    let searchNavigationController: UINavigationController
    let profileNavigationController: UINavigationController
    
    init() {
        showsNavigationController = UINavigationController()
        showsNavigationController.tabBarItem = UITabBarItem(title: "Shows", image: UIImage(named: "shows-icon"), tag: 0)
        
        searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        super.init(nibName: nil, bundle: nil)
        
        self.tabBar.tintColor = UIColor(rgb: 0xe58e26)
    
        
        viewControllers = [showsNavigationController, searchNavigationController, profileNavigationController]
    }
    
    required init?(coder: NSCoder) {
        fatalError("This is not implemented")
    }
    
}

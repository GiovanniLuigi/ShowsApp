//
//  TabBarCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation

final class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    
    init(navigator: Navigator, parent: Coordinator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let tabBarController = TabBarController()
        
        let showsNavigationController = tabBarController.showsNavigationController
        let showsCoordinator = ShowsCoordinator(navigator: UIKitNavigator(navigationController: showsNavigationController), parent: self)
        
        let searchNavigationController = tabBarController.searchNavigationController
        let searchCoordinator = SearchCoordinator(navigator: UIKitNavigator(navigationController: searchNavigationController), parent: self)
        
        let settingsNavigationController = tabBarController.settingsNavigationController
        let moreCoordinator = MoreCoordinator(navigator: UIKitNavigator(navigationController: settingsNavigationController), parent: self)
        
        tabBarController.modalPresentationStyle = .overFullScreen
        navigator.set([tabBarController], animated: false)
        
        
        showsCoordinator.start()
        searchCoordinator.start()
        moreCoordinator.start()
    }
}

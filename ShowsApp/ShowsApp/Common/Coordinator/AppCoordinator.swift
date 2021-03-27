//
//  AppCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    
    init(navigator: Navigator, parent: Coordinator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let tabBarCoordinator = TabBarCoordinator(navigator: navigator, parent: self)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
}

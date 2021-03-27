//
//  AppCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation


final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator?
    
    init(parent: Coordinator?, navigator: Navigator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let showsCoordinator = ShowsCoordinator(parent: self, navigator: navigator)
        childCoordinators.append(showsCoordinator)
        showsCoordinator.start()
    }
    
    
}

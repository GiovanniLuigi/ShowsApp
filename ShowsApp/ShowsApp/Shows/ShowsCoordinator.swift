//
//  ShowsCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation


protocol ShowsCoordinatorProtocol: Coordinator {
    
}

class ShowsCoordinator: ShowsCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator?
    
    init(parent: Coordinator?, navigator: Navigator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let showsViewController = ShowsViewController.instantiate()
        navigator?.push(showsViewController, animated: true)
    }
    
}

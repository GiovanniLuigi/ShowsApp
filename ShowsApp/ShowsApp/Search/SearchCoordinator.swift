//
//  SearchCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation


protocol SearchCoordinatorProtocol: Coordinator {
    
}

final class SearchCoordinator: SearchCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    
    init(navigator: Navigator, parent: Coordinator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let searchViewController = SearchViewController.instantiate()
        navigator.push(searchViewController, animated: true)
    }
    
}

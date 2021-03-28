//
//  ShowDetailCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation


protocol ShowDetailCoordinatorProtocol: Coordinator {
    
}


class ShowDetailCoordinator: ShowDetailCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    private let showID: Int
    
    init(navigator: Navigator, parent: Coordinator?, showID: Int) {
        self.parent = parent
        self.navigator = navigator
        self.showID = showID
    }
    
    func start() {
        let showDetailViewController = ShowDetailViewController.instantiate()
        navigator.push(showDetailViewController, animated: true)
    }
}

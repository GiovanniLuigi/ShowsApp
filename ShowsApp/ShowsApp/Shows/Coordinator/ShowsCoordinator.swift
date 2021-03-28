//
//  ShowsCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation


protocol ShowsCoordinatorProtocol: Coordinator {
    func startCardDetail(showID: Int) 
}

class ShowsCoordinator: ShowsCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    
    init(navigator: Navigator, parent: Coordinator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let showsViewController = ShowsViewController.instantiate()
        showsViewController.viewModel = ShowsViewModel(coordinator: self, service: ShowsService(executor: HttpExecutor.shared), viewDelegate: showsViewController)
        navigator.push(showsViewController, animated: true)
    }
    
    func startCardDetail(showID: Int) {
        let cardDetailCoordinator = ShowDetailCoordinator(navigator: navigator, parent: self, showID: showID)
        cardDetailCoordinator.start()
    }
    
}

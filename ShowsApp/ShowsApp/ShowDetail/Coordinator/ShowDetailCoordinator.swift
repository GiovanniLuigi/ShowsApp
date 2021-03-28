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
    private let show: ShowModel
    
    init(navigator: Navigator, parent: Coordinator?, show: ShowModel) {
        self.parent = parent
        self.navigator = navigator
        self.show = show
    }
    
    func start() {
        let showDetailViewController = ShowDetailViewController.instantiate()
        let service = ShowDetailService(executor: HttpExecutor.shared)
        let viewModel = ShowDetailViewModel(coordinator: self, service: service, viewDelegate: showDetailViewController, show: show)
        showDetailViewController.viewModel = viewModel
        
        navigator.push(showDetailViewController, animated: true)
    }
}

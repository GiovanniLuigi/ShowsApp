//
//  MoreCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Foundation


class MoreCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    
    init(navigator: Navigator, parent: Coordinator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let moreViewController = MoreViewController.instantiate()
        moreViewController.viewModel = MoreViewModel(service: MoreService(authProvider: AuthProvider.shared), coordinator: self)
        navigator.push(moreViewController, animated: true)
    }
    
    func startPinCreation(delegate: AuthDelegate) {
        let authCoordinator = AuthCoordinator(navigator: navigator, parent: self, type: .ceation, delegate: delegate)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    func startPinRemoval(delegate: AuthDelegate) {
        let authCoordinator = AuthCoordinator(navigator: navigator, parent: self, type: .removal, delegate: delegate)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
}

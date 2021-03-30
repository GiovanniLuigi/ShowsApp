//
//  AuthCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Foundation

enum AuthType {
    case ceation, removal, verification
}

protocol AuthDelegate {
    func didFinishWithSuccess()
    func didFinishWithError()
}

class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    private let type: AuthType
    let delegate: AuthDelegate
    
    init(navigator: Navigator, parent: Coordinator?, type: AuthType, delegate: AuthDelegate) {
        self.parent = parent
        self.navigator = navigator
        self.type = type
        self.delegate = delegate
    }
    
    func start() {
        let authViewController = AuthViewController.instantiate()
        let service = AuthService(authProvider: AuthProvider.shared)
        let viewModel = AuthViewModel(type: type, service: service, viewDelegate: authViewController, coordinator: self)
        authViewController.viewModel = viewModel
        navigator.push(authViewController, animated: true)
    }
}

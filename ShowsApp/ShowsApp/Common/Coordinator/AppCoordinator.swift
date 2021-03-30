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
    private let authProvider: AuthProvider
    
    init(navigator: Navigator, parent: Coordinator?, authProvider: AuthProvider) {
        self.parent = parent
        self.navigator = navigator
        self.authProvider = authProvider
    }
    
    func start() {
        if authProvider.authEnabled() {
            startAuth()
        } else {
            startApp()
        }
    }
    
    private func startAuth() {
        let authCoordinator = AuthCoordinator(navigator: navigator, parent: self, type: .verification, delegate: self)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    private func startApp() {
        let tabBarCoordinator = TabBarCoordinator(navigator: navigator, parent: self)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
}


extension AppCoordinator: AuthDelegate {
    func didFinishWithSuccess() {
        startApp()
    }
    
    func didFinishWithError() {
        startAuth()
    }
}

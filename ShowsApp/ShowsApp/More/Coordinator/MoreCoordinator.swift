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
        moreViewController.viewModel = MoreViewModel()
        navigator.push(moreViewController, animated: true)
    }
}

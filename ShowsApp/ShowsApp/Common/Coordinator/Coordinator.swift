//
//  Coordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var parent: Coordinator? { get }
    var navigator: Navigator { get }
    func start()
    func stop()
    func willStop()
    func didStop()
    func childDidStop(_ child: Coordinator)
    func dismiss()
}

extension Coordinator {
    func childDidStop(_ child: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return coordinator === child
        }) {
            childCoordinators.remove(at: index)
        }
    }

    func stop() {
        self.willStop()
        self.didStop()
    }
    
    func willStop() {
        self.navigator.pop(animated: true)
    }
    
    func didStop() {
        self.parent?.childDidStop(self)
    }
    
    func dismiss() {
        self.navigator.dismiss(animated: true, completion: nil)
    }
}

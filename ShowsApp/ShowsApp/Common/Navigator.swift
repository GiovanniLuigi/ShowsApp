//
//  Navigator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

protocol Navigator {
    func present(_ view: UIViewController, animated: Bool, completion: (() -> Void)?)
    func push(_ view: UIViewController, animated: Bool)
    func set(_ views: [UIViewController], animated: Bool)
    func popToRootView(animated: Bool)
    func pop(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

class UIKitNavigator: Navigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func present(_ view: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.navigationController.present(view, animated: animated, completion: completion)
    }
    
    func push(_ view: UIViewController, animated: Bool) {
        self.navigationController.pushViewController(view, animated: animated)
    }
    
    func set(_ views: [UIViewController], animated: Bool) {
        self.navigationController.setViewControllers(views, animated: animated)
    }
    
    func popToRootView(animated: Bool) {
        self.navigationController.popToRootViewController(animated: animated)
    }
    
    func pop(animated: Bool) {
        self.navigationController.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.navigationController.dismiss(animated: animated, completion: completion)
    }
}

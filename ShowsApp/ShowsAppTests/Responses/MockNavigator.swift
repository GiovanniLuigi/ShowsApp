//
//  MockNavigator.swift
//  ShowsAppTests
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import UIKit
@testable import ShowsApp

class MockNavigator: Navigator {
    func present(_ view: UIViewController, animated: Bool, completion: (() -> Void)?) {
        
    }
    
    func push(_ view: UIViewController, animated: Bool) {
        
    }
    
    func set(_ views: [UIViewController], animated: Bool) {
        
    }
    
    func popToRootView(animated: Bool) {
        
    }
    
    func pop(animated: Bool) {
        
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        
    }
}

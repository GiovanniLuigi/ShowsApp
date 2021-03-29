//
//  UIViewController+Extensions.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit


extension UIViewController: Storyboarded {}

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    func presentAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    
    func presentErrorMessage(message: String, title: String = "Error", canCancel: Bool = true, retryAction: (()->Void)? = nil) {
        var alertActions: [UIAlertAction] = []
        
        if canCancel {
            alertActions.append(
                UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            )
        }
        
        if retryAction != nil {
            alertActions.append(
                UIAlertAction(title: "Retry", style: .default, handler: { (_) in
                    retryAction?()
                })
            )
        }
        
        presentAlert(title: title, message: message, actions: alertActions)
    }
    
}

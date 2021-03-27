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
}

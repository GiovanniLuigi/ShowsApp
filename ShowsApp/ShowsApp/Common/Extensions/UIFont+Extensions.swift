//
//  UIFont+Extensions.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

extension UIFont {
    
    struct AppFonts {
        static let regular: String = "Roboto-Regular"
    }
    
    static let largeTitle: UIFont = UIFont(name: AppFonts.regular, size: 41) ?? UIFont.preferredFont(forTextStyle: .largeTitle)
    static let title1: UIFont = UIFont(name: AppFonts.regular, size: 28) ?? UIFont.preferredFont(forTextStyle: .title1)
    
}

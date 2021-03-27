//
//  Configurable.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation

protocol Configurable {
    func configure<T>(_ obj: T)
}

//
//  CacheProvider.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

final class CacheProvider {
    static let shared: CacheProvider = CacheProvider()
    let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func clear() {
        imageCache.removeAllObjects()
    }
}

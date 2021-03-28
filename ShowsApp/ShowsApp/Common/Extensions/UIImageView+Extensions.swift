//
//  UIImageView+Extensions.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

extension UIImageView {
    
    
    func setImage(from url: String, placeholder: UIImage? = nil) {
        if let placeholder = placeholder {
            image = placeholder
        }
        
        let imageCache = CacheProvider.shared.imageCache
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: url) else {
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = NSData(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                self?.image = UIImage(data: Data(referencing: data))
            }
        }
    }
    
}



//
//  UIImageView+Extensions.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

extension UIImageView {
    
    static func preFetchImage(urlString: String) -> URLSessionDataTask? {
        let imageCache = CacheProvider.shared.imageCache
        
        if let _ = imageCache.object(forKey: urlString as NSString) {
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            if let newImage = UIImage(data: data) {
                imageCache.setObject(newImage, forKey: urlString as NSString)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func setImage(from urlString: String, placeholder: UIImage? = nil, completion: (()->Void)? = nil) -> URLSessionDataTask? {
        if let placeholder = placeholder {
            image = placeholder
        }
        
        let imageCache = CacheProvider.shared.imageCache
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion?()
            image = cachedImage
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                completion?()
                return
            }
            
            if let _ = error {
                completion?()
                return
            }
            
            if let newImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion?()
                    self?.image = newImage
                }
                DispatchQueue.global(qos: .background).sync {
                    imageCache.setObject(newImage, forKey: urlString as NSString)
                }
            }
            
        }
        task.resume()
        return task
    }
    
}



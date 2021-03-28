//
//  UIImageView+Extensions.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

extension UIImageView {
    
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
                return
            }
            
            DispatchQueue.main.async {
                if let newImage = UIImage(data: data) {
//                   let compressedImageData = newImage.jpegData(compressionQuality: 0.25),
//                   let compressedImage = UIImage(data: compressedImageData) {
                    completion?()
                    self?.image = newImage
                    imageCache.setObject(newImage, forKey: urlString as NSString)
                }
            }
        }
        task.resume()
        return task
    }
    
}



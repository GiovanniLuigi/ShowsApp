//
//  UICollectionViewCell.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit


extension UICollectionView {
    
    func dequeue<CellType: UICollectionViewCell, T>(_ type: CellType.Type, indexPath: IndexPath, viewModel: T) -> UICollectionViewCell {
        
        let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath)
        
        if let configurable = cell as? Configurable {
            configurable.configure(viewModel)
        }
        
        return cell
    }
    
}

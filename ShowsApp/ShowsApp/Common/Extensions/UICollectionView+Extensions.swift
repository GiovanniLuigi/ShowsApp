//
//  UICollectionViewCell.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit


extension UICollectionView {
    
    func dequeue<CellType: UICollectionViewCell>(_ type: CellType.Type, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath)
        return cell
    }
    
}

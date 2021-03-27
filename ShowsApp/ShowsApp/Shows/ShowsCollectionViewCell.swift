//
//  ShowsCollectionViewCell.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

class ShowsCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .red
    }

}

extension ShowsCollectionViewCell: Configurable {
    func configure<String>(_ obj: String) {
        
    }
}

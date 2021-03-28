//
//  ShowsCollectionViewCell.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

class ShowsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 8
    }
}

extension ShowsCollectionViewCell: Configurable {
    private typealias ViewModel = ShowsCollectionViewCellViewModel
    
    func configure<ViewModel>(_ obj: ViewModel) {
        
    }
}

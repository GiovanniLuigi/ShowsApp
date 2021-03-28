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
    var task: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
       clear()
    }
    
    func clear() {
        print(task?.state.rawValue)
        task?.cancel()
        task = nil
        coverImageView.image = nil
        titleLabel.text = ""
    }
}

extension ShowsCollectionViewCell {
    
    func configure(viewModel: ShowsCollectionViewCellViewModel) {
        task = coverImageView.setImage(from: viewModel.coverImageURL)
        titleLabel.text = viewModel.title
    }
}

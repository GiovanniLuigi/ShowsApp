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
        coverImageView.skeletonCornerRadius = 8
        titleLabel.skeletonCornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    func clear() {
        task?.cancel()
        task = nil
        coverImageView.image = nil
        titleLabel.text = ""
        showAnimatedSkeleton()
    }
}

extension ShowsCollectionViewCell {
    func configure(viewModel: ShowsCollectionViewCellViewModel) {
        task = coverImageView.setImage(from: viewModel.coverImageURL) { [weak self] in
            self?.titleLabel.text = viewModel.title
            self?.hideSkeleton()
        }
    }
}

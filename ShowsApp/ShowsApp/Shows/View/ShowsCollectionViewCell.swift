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
    private var task: URLSessionDataTask?
    private var viewModel: ShowsCollectionViewCellViewModel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 8
        coverImageView.skeletonCornerRadius = 8
        titleLabel.skeletonCornerRadius = 8
        titleLabel.linesCornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    func clear() {
        task?.cancel()
        task = nil
        coverImageView.image = nil
        viewModel = nil
        titleLabel.text = String.empty
        showAnimatedSkeleton()
    }
}

extension ShowsCollectionViewCell {
    func configure(viewModel: ShowsCollectionViewCellViewModel) {
        if self.viewModel == viewModel {
            return
        }
        task = coverImageView.setImage(from: viewModel.coverImageURL) { [weak self] in
            self?.titleLabel.text = viewModel.title
            self?.hideSkeleton(transition: .crossDissolve(0.5))
        }
    }
}

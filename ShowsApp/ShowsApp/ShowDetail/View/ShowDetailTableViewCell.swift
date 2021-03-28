//
//  ShowDetailTableViewCell.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

class ShowDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        showAnimatedSkeleton()
    }
}

extension ShowDetailTableViewCell {
    func configure(viewModel: ShowDetailCellViewModel) {
        let _ = coverImageView.setImage(from: viewModel.coverImageURL) { [weak self] in
            self?.titleLabel.text = viewModel.title
            self?.hideSkeleton()
        }
    }
}

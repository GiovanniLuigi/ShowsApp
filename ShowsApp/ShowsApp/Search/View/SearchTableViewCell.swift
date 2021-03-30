//
//  SearchTableViewCell.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    
    private var task: URLSessionTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 8
        title.linesCornerRadius = 8
        genresLabel.linesCornerRadius = 8
        selectionStyle = .none
        showAnimatedSkeleton()
    }
  
    func clear() {
        showAnimatedSkeleton()
        task?.cancel()
        task = nil
        title.text = String.empty
        genresLabel.text = String.empty
        coverImageView.image = nil
    }
}


extension SearchTableViewCell {
    func configure(viewModel: SearchTableViewCellViewModel) {
        task = coverImageView.setImage(from: viewModel.coverImageURL) { [weak self] success in
            if !success {
                self?.coverImageView.showPlaceholder()
            }
            self?.title.text = viewModel.title
            self?.genresLabel.text = viewModel.genresString
            self?.hideSkeleton()
        }
    }
}

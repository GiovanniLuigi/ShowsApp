//
//  EpisodeDetailViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    
    var viewModel: EpisodeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
        
        if !viewModel.hasCoverImage {
            imageHeightConstraint.isActive = false
            view.layoutIfNeeded()
        }
        coverImageView.setImage(from: viewModel.coverImageURL)
        episodeNameLabel.text = viewModel.episodeTitle
        summaryLabel.text = viewModel.summary
        detailsLabel.text = viewModel.detailsText
    }
}

extension EpisodeDetailViewController: EpisodeDetailViewDelegate {
    
}

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
        
        if !viewModel.hasCoverImage {
            imageHeightConstraint.isActive = false
            view.layoutIfNeeded()
        } else {
            coverImageView.showAnimatedSkeleton()
            coverImageView.setImage(from: viewModel.coverImageURL) { [weak self] _ in
                self?.coverImageView.hideSkeleton()
            }
        }
        
        episodeNameLabel.text = viewModel.episodeTitle
        summaryLabel.text = viewModel.summary
        detailsLabel.text = viewModel.detailsText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
    }
}

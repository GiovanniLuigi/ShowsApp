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
    
    var viewModel: EpisodeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
    }
}

extension EpisodeDetailViewController: EpisodeDetailViewDelegate {
    
}

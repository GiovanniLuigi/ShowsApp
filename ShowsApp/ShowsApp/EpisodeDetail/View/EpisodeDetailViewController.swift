//
//  EpisodeDetailViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    var viewModel: EpisodeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
    }
}

extension EpisodeDetailViewController: EpisodeDetailViewDelegate {
    
}

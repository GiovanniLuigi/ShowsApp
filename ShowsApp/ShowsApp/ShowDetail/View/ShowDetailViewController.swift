//
//  ShowDetailViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

class ShowDetailViewController: UIViewController {

    var viewModel: ShowDetailViewModel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var seasonsButton: UIButton!
    @IBOutlet weak var episodesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.register(ShowDetailTableViewCell.nib, forCellReuseIdentifier: ShowDetailTableViewCell.identifier)
        
        
        view.startSkeletonAnimation()
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        scheduleLabel.text = viewModel.schedule
        summaryLabel.text = viewModel.summary
        
        coverImageView.setImage(from: viewModel.coverImageURL) { [weak self] in
            self?.view.stopSkeletonAnimation()
        }
        
        
    }
    
    @IBAction func didPressSeasonsButton(_ sender: Any) {
        
    }
    
}

extension ShowDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ShowDetailTableViewCell.self, indexPath: indexPath)
        
        if let cell = cell as? ShowDetailTableViewCell {
            cell.configure(viewModel: viewModel.cellViewModel(indexPath: indexPath))
        }
        
        return cell
    }
}

extension ShowDetailViewController: UITableViewDelegate {}

extension ShowDetailViewController: ShowDetailViewDelegate {
    
}

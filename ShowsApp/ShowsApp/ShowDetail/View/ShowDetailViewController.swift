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
        episodesTableView.separatorStyle = .none
        episodesTableView.isScrollEnabled = false
        
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        scheduleLabel.text = viewModel.schedule
        summaryLabel.text = viewModel.summary
        coverImageView.setImage(from: viewModel.coverImageURL)
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            shouldReloadTableVieSize()
    }
    
    @IBAction func didPressSeasonsButton(_ sender: Any) {
        
    }
    
    private func shouldReloadTableVieSize() {
        self.view.layoutIfNeeded()
        self.tableViewHeightConstraint.constant = self.episodesTableView.contentSize.height + 16
        self.view.layoutIfNeeded()
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

extension ShowDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ShowDetailViewController: ShowDetailViewDelegate {
    
}

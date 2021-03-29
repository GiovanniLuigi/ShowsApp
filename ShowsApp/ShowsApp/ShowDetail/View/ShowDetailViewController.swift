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
    @IBOutlet weak var episodesTableView: UITableView!
    @IBOutlet weak var seasonButtonView: UIView!
    @IBOutlet weak var seasonButtonTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.register(ShowDetailTableViewCell.nib, forCellReuseIdentifier: ShowDetailTableViewCell.identifier)
        episodesTableView.separatorStyle = .none
        episodesTableView.isScrollEnabled = false
        seasonButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressSeasonsButton)))
        seasonButtonView.layer.cornerRadius = 16
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
        title = viewModel.navTitle
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        scheduleLabel.text = viewModel.schedule
        summaryLabel.text = viewModel.summary
        coverImageView.showAnimatedSkeleton()
        coverImageView.setImage(from: viewModel.coverImageURL) { [weak self] in
            self?.coverImageView.hideSkeleton()
        }
        
        viewModel.fetchSeasons()
    }
    
    @objc func didPressSeasonsButton() {
        viewModel.showSeasonPicker()
    }
    
    private func shouldReloadTableVieSize() {
        self.view.layoutIfNeeded()
        self.tableViewHeightConstraint.constant = self.episodesTableView.contentSize.height + 16
        self.view.layoutIfNeeded()
    }
    
    private func reloadView() {
        episodesTableView.reloadData()
        seasonButtonTitleLabel.text = viewModel.currentSeasonTitle
    }
    
    private func startSkeleton() {
        
    }
    
    private func hideSkeleton() {
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                shouldReloadTableVieSize()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath)
    }
}

extension ShowDetailViewController: ShowDetailViewDelegate {
    func didStartLoading() {
        startSkeleton()
    }
    
    func didFinishLoading() {
        hideSkeleton()
    }
    
    func didFetchEpisodesWithSuccess() {
        reloadView()
    }
    
    func didFetchEpisodesWithError() {
        print("Did fetch espisodes error")
    }
    
    func didFetchSeasonsWithSuccess() {
        seasonButtonTitleLabel.text = viewModel.currentSeasonTitle
        viewModel.fetchEpisodes(seasonIndex: viewModel.seasonIndex)
    }
    
    func didFetchSeasonsWithError() {
        print("Did fetch season with error")
    }
}

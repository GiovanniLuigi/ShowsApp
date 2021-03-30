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
        title = viewModel.navTitle
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        scheduleLabel.text = viewModel.schedule
        summaryLabel.text = viewModel.summary
        coverImageView.showAnimatedSkeleton()
        coverImageView.setImage(from: viewModel.coverImageURL) { [weak self] success in
            if !success {
                self?.coverImageView.showPlaceholder()
            }
            self?.coverImageView.hideSkeleton()
        }
        
        seasonButtonView.showAnimatedSkeleton()
        viewModel.fetchSeasons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
    }
    
    @objc func didPressSeasonsButton() {
        viewModel.showSeasonPicker()
    }
    
    private func shouldReloadTableVieSize() {
        self.view.layoutIfNeeded()
        self.tableViewHeightConstraint.constant = CGFloat(viewModel.numberOfRowsInSection()*100)
        self.view.layoutIfNeeded()
    }
    
    private func reloadView() {
        episodesTableView.reloadData()
        seasonButtonTitleLabel.text = viewModel.currentSeasonTitle
        shouldReloadTableVieSize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            viewModel.stop()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath)
    }
}

extension ShowDetailViewController: ShowDetailViewDelegate {
    func didUpdateCurrentSeason() {
        seasonButtonTitleLabel.text = viewModel.currentSeasonTitle
    }
    
    func didStartToFetchEpisodes() {
        reloadView()
    }
    
    func didFetchEpisodesWithSuccess() {
        reloadView()
    }
    
    func didFetchEpisodesWithError() {
        presentErrorMessage(message: viewModel.errorMessage) { [weak self] in
            guard let seasonIndex = self?.viewModel.seasonIndex else { return }
            self?.viewModel.fetchEpisodes(seasonIndex: seasonIndex)
        }
    }
    
    func didFetchSeasonsWithSuccess() {
        seasonButtonView.hideSkeleton()
        seasonButtonTitleLabel.text = viewModel.currentSeasonTitle
        viewModel.fetchEpisodes(seasonIndex: viewModel.seasonIndex)
    }
    
    func didFetchSeasonsWithError() {
        presentErrorMessage(message: viewModel.errorMessage) { [weak self] in
            self?.viewModel.fetchSeasons()
        }
    }
}

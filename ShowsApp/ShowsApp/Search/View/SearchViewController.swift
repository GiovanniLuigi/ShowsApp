//
//  SearchViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension SearchViewController {
    
    
    private func setupView() {
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchBarPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
}

extension SearchViewController: SearchViewDelegate {
    func didStartLoading() {
        navigationItem.searchController?.searchBar.isLoading = true
    }
    
    func didFinishLoading() {
        navigationItem.searchController?.searchBar.isLoading = false
    }
    
    func didQueryUpdateWithSuccess() {
        tableView.reloadData()
    }
    
    func didQueryWithError() {
        
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchText = searchBar.text else {
            return
        }
        
        viewModel.updateQuery(text: searchText)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }

    @objc private func reload(_ searchBar: UISearchBar) {
        viewModel.query()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.numberOfRowsInSection()
        
        if count == 0 {
            self.tableView.setEmptyMessage(viewModel.emptyTableViewMessage)
        } else {
            self.tableView.restore()
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SearchTableViewCell.self, indexPath: indexPath)
        
        if let cell = cell as? SearchTableViewCell {
            cell.configure(viewModel: viewModel.cellViewModel(indexPath: indexPath))
        }
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

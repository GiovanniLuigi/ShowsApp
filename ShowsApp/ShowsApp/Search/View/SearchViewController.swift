//
//  SearchViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
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
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
}

extension SearchViewController: SearchViewDelegate {
    func didStartLoading() {
        searchBar.isLoading = true
    }
    
    func didFinishLoading() {
        searchBar.isLoading = false
    }
    
    func didQueryUpdateWithSuccess() {
        tableView.reloadData()
    }
    
    func didQueryWithError() {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateQuery(text: searchText)
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }

    @objc func reload(_ searchBar: UISearchBar) {
        viewModel.query()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
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

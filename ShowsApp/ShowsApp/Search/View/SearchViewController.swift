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
    }
}

extension SearchViewController: SearchViewDelegate {
    func didQueryWithSuccess() {
        
    }
    
    func didQueryWithError() {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.queryString = searchText
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }

    @objc func reload(_ searchBar: UISearchBar) {
        viewModel.query()
    }
}


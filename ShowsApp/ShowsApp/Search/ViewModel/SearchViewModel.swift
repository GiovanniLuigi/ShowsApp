//
//  SearchViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation


protocol SearchViewDelegate {
    func didQueryUpdateWithSuccess()
    func didQueryWithError()
    func didStartLoading()
    func didFinishLoading()
}

class SearchViewModel {
    let viewDelegate: SearchViewDelegate
    let coordinator: SearchCoordinatorProtocol
    let service: SearchService
    
    private var currentQueries: [SearchQueryModel] = []
    private var currentError: Error?
    private var queryString: String = ""
    
    init(coordinator: SearchCoordinatorProtocol, service: SearchService, viewDelegate: SearchViewDelegate) {
        self.coordinator = coordinator
        self.service = service
        self.viewDelegate = viewDelegate
    }
    
    func updateQuery(text: String) {
        queryString = text
    }
    
    func query() {
        currentQueries = []
        viewDelegate.didQueryUpdateWithSuccess()
        
        let formattedString = formatQueryString()
        if isValidQueryString(formattedString) {
            viewDelegate.didStartLoading()
            service.fetch(query: formattedString) { [weak self] (result) in
                self?.viewDelegate.didFinishLoading()
                switch result {
                case .success(let queries):
                    self?.currentQueries = queries
                    self?.viewDelegate.didQueryUpdateWithSuccess()
                case .failure(let error):
                    self?.currentError = error
                    self?.viewDelegate.didQueryWithError()
                }
            }
        }
    }
    
    func numberOfRowsInSection(section: Int = 0) -> Int {
        return currentQueries.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> SearchTableViewCellViewModel {
        let queryModel = currentQueries[indexPath.row]
        return SearchTableViewCellViewModel(title: queryModel.show?.name ?? "")
    }
    
}

extension SearchViewModel {
    private func formatQueryString() -> String {
        return queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    private func isValidQueryString(_ queryString: String) -> Bool {
        return queryString.trimmingCharacters(in: .whitespaces) != ""
    }
}


extension SearchViewModel {
    
    var title: String {
        return "Search"
    }
    
    var searchBarPlaceholder: String {
        return "Title"
    }
    
    var emptyTableViewMessage: String {
        return "No search results yet"
    }
    
    var errorMessage: String {
        return currentError?.localizedDescription ?? "An error ocurred"
    }
    
}

//
//  SearchViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation


protocol SearchViewDelegate {
    func didQueryWithSuccess()
    func didQueryWithError()
}

class SearchViewModel {
    let viewDelegate: SearchViewDelegate
    let coordinator: SearchCoordinatorProtocol
    let service: SearchService
    
    private var currentQueries: [SearchQueryModel] = []
    private var currentError: Error?
    var queryString: String = ""
    
    init(coordinator: SearchCoordinatorProtocol, service: SearchService, viewDelegate: SearchViewDelegate) {
        self.coordinator = coordinator
        self.service = service
        self.viewDelegate = viewDelegate
    }
    
    func query() {
        let formattedString = formatQueryString()
        if isValidQueryString(formattedString) {
            service.fetch(query: formattedString) { [weak self] (result) in
                switch result {
                case .success(let queries):
                    self?.currentQueries = queries
                    self?.viewDelegate.didQueryWithSuccess()
                case .failure(let error):
                    self?.currentError = error
                    self?.viewDelegate.didQueryWithError()
                }
            }
        }
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
    
    var errorMessage: String {
        return currentError?.localizedDescription ?? "An error ocurred"
    }
    
}

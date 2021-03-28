//
//  SearchViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation


protocol SearchViewDelegate {
    
}

class SearchViewModel {
    let viewDelegate: SearchViewDelegate
    let coordinator: SearchCoordinatorProtocol
    let service: SearchService
    
    init(coordinator: SearchCoordinatorProtocol, service: SearchService, viewDelegate: SearchViewDelegate) {
        self.coordinator = coordinator
        self.service = service
        self.viewDelegate = viewDelegate
    }
    
}


extension SearchViewModel {
    
    var title: String {
        return "Search"
    }
    
}

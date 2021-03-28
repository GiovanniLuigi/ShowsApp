//
//  ShowsViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation


protocol ShowsViewDelegate {
    func didFetchShowsWithSuccess()
    func didFetchShowsWithError()
}

class ShowsViewModel {
    private let coordinator: ShowsCoordinatorProtocol
    private let service: ShowsService
    private let viewDelegate: ShowsViewDelegate
    private var page: Int
    
    private var currentShows: [ShowModel]?
    private var currentError: Error?
    
    init(coordinator: ShowsCoordinatorProtocol, service: ShowsService, viewDelegate: ShowsViewDelegate) {
        self.coordinator = coordinator
        self.service = service
        self.viewDelegate = viewDelegate
        self.page = 0
    }
    
    func fetchNextPage() {
        service.fetchShows(page: page) { [weak self] result in
            switch result {
            case .success(let shows):
                self?.currentShows = shows
                self?.page += 1
                self?.viewDelegate.didFetchShowsWithSuccess()
            case .failure(let error):
                self?.currentError = error
                self?.viewDelegate.didFetchShowsWithError()
            }
        }
    }
    
}

extension ShowsViewModel {
    var title: String {
        return "Shows"
    }
    
    var prefersLargeTitle: Bool {
        return true
    }
    
    var shows: [ShowModel] {
        return currentShows ?? []
    }
    
    var errorMessage: String {
        return currentError?.localizedDescription ?? "An error occurred"
    }
    
    func numberOfItemsInSection(section: Int = 0) -> Int {
        return shows.count
    }
    
    func cellViewModel(_ indexPath: IndexPath) -> ShowsCollectionViewCellViewModel {
        let show = shows[indexPath.row]
        return ShowsCollectionViewCellViewModel(coverImageURL: show.image?.medium ?? "", title: show.name ?? "")
    }
    
}

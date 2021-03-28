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
    
    private var currentShows: [ShowModel] = []
    private var currentError: Error?
    private var isFetching: Bool = false
    
    init(coordinator: ShowsCoordinatorProtocol, service: ShowsService, viewDelegate: ShowsViewDelegate) {
        self.coordinator = coordinator
        self.service = service
        self.viewDelegate = viewDelegate
        self.page = 0
    }
    
    func fetchNextPage() {
        isFetching = true
        service.fetchShows(page: page) { [weak self] result in
            switch result {
            case .success(let shows):
                self?.currentShows.append(contentsOf: shows)
                self?.page += 1
                self?.viewDelegate.didFetchShowsWithSuccess()
            case .failure(let error):
                self?.currentError = error
                self?.viewDelegate.didFetchShowsWithError()
            }
            self?.isFetching = false
        }
    }
    
    func selectCell(at: IndexPath) {
        let show = shows[at.row]
        coordinator.startCardDetail(show: show)
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
        return currentShows
    }
    
    var errorMessage: String {
        return currentError?.localizedDescription ?? "An error occurred"
    }
    
    var isLoading: Bool {
        return isFetching
    }
    
    func numberOfItemsInSection(section: Int = 0) -> Int {
        return shows.count
    }
    
    func cellViewModel(_ indexPath: IndexPath) -> ShowsCollectionViewCellViewModel? {
        guard indexPath.row < shows.count, shows.count > 0 else {
            return nil
        }
        let show = shows[indexPath.row]
        return ShowsCollectionViewCellViewModel(coverImageURL: show.image?.medium ?? "", title: show.name ?? "")
    }
    
}

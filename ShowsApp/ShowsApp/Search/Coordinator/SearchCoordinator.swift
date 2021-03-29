//
//  SearchCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation


protocol SearchCoordinatorProtocol: Coordinator {
    func startShowDetail(show: ShowModel)
}

final class SearchCoordinator: SearchCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    
    init(navigator: Navigator, parent: Coordinator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let searchViewController = SearchViewController.instantiate()
        let service = SearchService(executor: HttpExecutor.shared)
        let viewModel = SearchViewModel(coordinator: self, service: service, viewDelegate: searchViewController)
        searchViewController.viewModel = viewModel
        navigator.push(searchViewController, animated: true)
    }
    
    func startShowDetail(show: ShowModel) {
        let showDetailCoordinator = ShowDetailCoordinator(navigator: navigator, parent: self, show: show)
        childCoordinators.append(showDetailCoordinator)
        showDetailCoordinator.start()
    }
    
}

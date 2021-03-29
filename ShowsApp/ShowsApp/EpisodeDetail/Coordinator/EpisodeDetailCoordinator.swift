//
//  EpisodeDetailCoordinator.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import Foundation

protocol EpisodeDetailCoordinatorProtocol: Coordinator {}

class EpisodeDetailCoordinator: EpisodeDetailCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    private(set) var parent: Coordinator?
    private(set) var navigator: Navigator
    
    init(navigator: Navigator, parent: Coordinator?) {
        self.parent = parent
        self.navigator = navigator
    }
    
    func start() {
        let episodeDetailViewController = EpisodeDetailViewController.instantiate()
        let viewModel = EpisodeDetailViewModel(coordinator: self, viewDelegate: episodeDetailViewController)
        episodeDetailViewController.viewModel = viewModel
        navigator.push(episodeDetailViewController, animated: true)
    }
}

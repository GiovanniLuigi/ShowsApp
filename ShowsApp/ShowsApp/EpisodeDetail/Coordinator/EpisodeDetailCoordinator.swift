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
    private let episodeModel: EpisodeDetailModel
    
    init(navigator: Navigator, parent: Coordinator?, episodeModel: EpisodeDetailModel) {
        self.parent = parent
        self.navigator = navigator
        self.episodeModel = episodeModel
    }
    
    func start() {
        let episodeDetailViewController = EpisodeDetailViewController.instantiate()
        let viewModel = EpisodeDetailViewModel(coordinator: self, episodeModel: episodeModel)
        episodeDetailViewController.viewModel = viewModel
        navigator.push(episodeDetailViewController, animated: true)
    }
}

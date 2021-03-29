//
//  EpisodeDetailViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import Foundation

protocol EpisodeDetailViewDelegate {
    
}

class EpisodeDetailViewModel {
    private let coordinator: EpisodeDetailCoordinatorProtocol
    private let viewDelegate: EpisodeDetailViewDelegate
  
    init(coordinator: EpisodeDetailCoordinatorProtocol, viewDelegate: EpisodeDetailViewDelegate) {
        self.coordinator = coordinator
        self.viewDelegate = viewDelegate
    }
}


extension EpisodeDetailViewModel {
    var title: String {
        return "Episode detail"
    }
    
    var prefersLargeTitles: Bool {
        return false
    }
}

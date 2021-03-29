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
    private let episodeModel: EpisodeDetailModel
  
    init(coordinator: EpisodeDetailCoordinatorProtocol, viewDelegate: EpisodeDetailViewDelegate, episodeModel: EpisodeDetailModel) {
        self.coordinator = coordinator
        self.viewDelegate = viewDelegate
        self.episodeModel = episodeModel
    }
}


extension EpisodeDetailViewModel {
    var title: String {
        return "Episode detail"
    }
    
    var prefersLargeTitles: Bool {
        return false
    }
    
    var hasCoverImage: Bool {
        return episodeModel.coverImageURL != nil
    }
    
    var coverImageURL: String {
        return episodeModel.coverImageURL ?? ""
    }
    
    var episodeTitle: String {
        return episodeModel.title
    }
    
    var summary: String {
        return episodeModel.summary.htmlDecoded
    }
    
    var detailsText: String {
        let seasonText = "Season \(episodeModel.seasonNumber)"
        let episodeText = "Episode \(episodeModel.episodeNumber)"
        
        return "\(seasonText) • \(episodeText)"
    }
}

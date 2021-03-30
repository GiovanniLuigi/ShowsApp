//
//  EpisodeDetailViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import Foundation

class EpisodeDetailViewModel {
    private let coordinator: EpisodeDetailCoordinatorProtocol
    private let episodeModel: EpisodeDetailModel
  
    init(coordinator: EpisodeDetailCoordinatorProtocol, episodeModel: EpisodeDetailModel) {
        self.coordinator = coordinator
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
        return !coverImageURL.isEmpty
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

//
//  ShowDetailViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation

protocol ShowDetailViewDelegate {
    
}

class ShowDetailViewModel {
    private let coordinator: ShowDetailCoordinatorProtocol
    private let service: ShowDetailService
    private let viewDelegate: ShowDetailViewDelegate
    private let show: ShowModel
    
    init(coordinator: ShowDetailCoordinatorProtocol, service: ShowDetailService, viewDelegate: ShowDetailViewDelegate, show: ShowModel) {
        self.coordinator = coordinator
        self.service = service
        self.viewDelegate = viewDelegate
        self.show = show
    }
    
    func numberOfRowsInSection() -> Int {
        return 10
    }
    
    func cellViewModel(indexPath: IndexPath) -> ShowDetailCellViewModel {
        return ShowDetailCellViewModel()
    }
}

extension ShowDetailViewModel {
    var coverImageURL: String {
        return show.image?.original ?? String.empty
    }
    
    var title: String {
        return show.name ?? String.empty
    }
    
    var genres: String {
        return show.genres?.joined(separator: " • ") ?? String.empty
    }
    
    var schedule: String {
        var formattedSchedule = show.schedule?.days ?? []
        let time = show.schedule?.time ?? String.empty
        formattedSchedule.append(time)
        return formattedSchedule.joined(separator: " • ")
    }
    
    var summary: String {
        return show.summary?.htmlDecoded ?? String.empty
    }
}

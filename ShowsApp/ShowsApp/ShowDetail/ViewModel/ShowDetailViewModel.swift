//
//  ShowDetailViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation

protocol ShowDetailViewDelegate {
    func didFetchSeasonsWithSuccess()
    func didFetchSeasonsWithError()
    
    func didFetchEpisodesWithSuccess()
    func didFetchEpisodesWithError()
}

class ShowDetailViewModel {
    private let coordinator: ShowDetailCoordinatorProtocol
    private let service: ShowDetailService
    private let viewDelegate: ShowDetailViewDelegate
    private let show: ShowModel
    
    private var seasons: [SeasonModel] = []
    private var episodes: [[EpisodesModel]] = []
    private var error: Error?
    private var currentSeason: Int = 0
    
    init(coordinator: ShowDetailCoordinatorProtocol, service: ShowDetailService, viewDelegate: ShowDetailViewDelegate, show: ShowModel) {
        self.coordinator = coordinator
        self.service = service
        self.viewDelegate = viewDelegate
        self.show = show
    }
    
    func fetchSeasons() {
        guard let id = show.id else {
            return
        }
        
        service.fetchSeasons(showID: id) { [weak self] (result) in
            switch result {
            case .success(let model):
                self?.seasons = model
                model.forEach { _ in
                    self?.episodes.append([])
                }
                self?.viewDelegate.didFetchSeasonsWithSuccess()
            case .failure(let error):
                self?.error = error
                self?.viewDelegate.didFetchSeasonsWithError()
            }
        }
    }
    
    func fetchEpisodes(seasonIndex: Int) {
        guard seasonIndex < seasons.count,
              seasonIndex >= 0,
              let seasonID = seasons[seasonIndex].id else {
            error = nil
            viewDelegate.didFetchEpisodesWithError()
            return
        }
        
        service.fetchEpisodes(seasonID: seasonID) { [weak self] (result) in
            self?.currentSeason = seasonIndex
            switch result {
            case .success(let model):
                self?.episodes[seasonIndex] = model
                self?.viewDelegate.didFetchEpisodesWithSuccess()
            case .failure(let error):
                self?.error = error
                self?.viewDelegate.didFetchEpisodesWithError()
            }
        }
    }
    
    func showSeasonPicker() {
        coordinator.startSeasonPicker(seasons: seasons, currentSeason: currentSeason, delegate: self)
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
    
    var seasonIndex: Int {
        return currentSeason
    }
    
    func numberOfRowsInSection() -> Int {
        if seasonIndex > episodes.count-1 {
            return 0
        }
        
        return episodes[seasonIndex].count
    }
    
    func cellViewModel(indexPath: IndexPath) -> ShowDetailCellViewModel {
        let episode = episodes[currentSeason][indexPath.row]
        return ShowDetailCellViewModel(title: episode.name ?? String.empty, number: episode.number, coverImageURL: episode.image?.medium ?? "")
    }
}


extension ShowDetailViewModel: SeasonPickerDelegate {
    func didSelect(seasonID: Int) {
        print("selected season \(seasonID)")
    }
    
    
}

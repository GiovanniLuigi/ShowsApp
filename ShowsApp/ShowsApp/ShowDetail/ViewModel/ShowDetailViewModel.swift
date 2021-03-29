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
    func didUpdateCurrentSeason()
    
    func didFetchEpisodesWithSuccess()
    func didFetchEpisodesWithError()
    func didStartToFetchEpisodes()
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
    var isLoading: Bool = true
    
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
            self?.viewDelegate.didUpdateCurrentSeason()
            switch result {
            case .success(let model):
                self?.episodes[seasonIndex] = model
                self?.viewDelegate.didFetchEpisodesWithSuccess()
            case .failure(let error):
                self?.error = error
                self?.viewDelegate.didFetchEpisodesWithError()
            }
            self?.isLoading = false
        }
    }
    
    func showSeasonPicker() {
        coordinator.startSeasonPicker(seasons: seasons, currentSeason: currentSeason, delegate: self)
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        let episode = episodes[currentSeason][indexPath.row]
        let season = seasons[currentSeason]
        let detailModel = EpisodeDetailModel(
            title: episode.name ?? String.empty,
            seasonNumber: season.number ?? 1,
            episodeNumber: episode.number ?? 1,
            summary: episode.summary ?? String.empty,
            coverImageURL: episode.image?.original ?? "")
        coordinator.startEpisodeDetail(episodeModel: detailModel)
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
        if !time.isEmpty {
            formattedSchedule.append(time)
        }
        return formattedSchedule.joined(separator: " • ")
    }
    
    var summary: String {
        return show.summary?.htmlDecoded ?? String.empty
    }
    
    var seasonIndex: Int {
        return currentSeason
    }
    
    var currentSeasonTitle: String {
        return "Season \(currentSeason+1)"
    }
    
    var navTitle: String {
        return "Show detail"
    }
    
    var prefersLargeTitles: Bool {
        return false
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
    func didSelect(seasonIndex: Int) {
        currentSeason = seasonIndex
        viewDelegate.didStartToFetchEpisodes()
        viewDelegate.didUpdateCurrentSeason()
        fetchEpisodes(seasonIndex: seasonIndex)
    }
}

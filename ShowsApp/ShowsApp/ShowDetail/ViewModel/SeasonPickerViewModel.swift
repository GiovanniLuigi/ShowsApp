//
//  SeasonPickerViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import Foundation

protocol SeasonPickerDelegate {
    func didSelect(seasonIndex: Int)
}

class SeasonPickerViewModel {
    private let seasons: [PickerSeasonModel]
    private let delegate: SeasonPickerDelegate
    private let coodinator: ShowDetailCoordinatorProtocol
    private let currentSeason: Int
    
    init(seasons: [SeasonModel], delegate: SeasonPickerDelegate, currentSeason: Int, coodinator: ShowDetailCoordinatorProtocol) {
        self.delegate = delegate
        self.coodinator = coodinator
        self.currentSeason = currentSeason
        self.seasons = seasons.filter { $0.id != nil && $0.number != nil }.map { PickerSeasonModel(id: $0.id ?? 1, number: $0.number ?? 1) }
    }
    
    func shouldFinish() {
        coodinator.dismiss()
    }
    
    func didFinish(selectedSeasonIndex: Int) {
        delegate.didSelect(seasonIndex: selectedSeasonIndex)
    }
}


extension SeasonPickerViewModel {
    var seasonsTitles: [String] {
        return seasons.compactMap { $0.title }
    }
    
    var initialRow: Int {
        return currentSeason
    }
    
    func numberOfSeasons() -> Int {
        return seasonsTitles.count
    }
    
    func seasonTitle(at index: Int) -> String {
        return seasonsTitles[index]
    }
    
    
}

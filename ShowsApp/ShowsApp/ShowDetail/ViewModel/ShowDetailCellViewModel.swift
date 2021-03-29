//
//  ShowDetailCellViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation


struct ShowDetailCellViewModel {
    let title: String = "Invernal Soldier"
    let number: Int = 1
    let coverImageURL: String = "https://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg"
    
    var episodeTitle: String {
        return "\(number). \(title)"
    }
}

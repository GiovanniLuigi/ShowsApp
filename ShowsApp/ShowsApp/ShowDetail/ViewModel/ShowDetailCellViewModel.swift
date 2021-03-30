//
//  ShowDetailCellViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation


struct ShowDetailCellViewModel {
    let title: String
    let number: Int?
    let coverImageURL: String
    
    var episodeTitle: String {
        if let number = number {
            return "\(number). \(title)"
        }
        return title
    }
}

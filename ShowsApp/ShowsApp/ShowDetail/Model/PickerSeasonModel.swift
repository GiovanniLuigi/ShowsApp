//
//  PickerSeasonModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import Foundation

struct PickerSeasonModel {
    let id: Int
    let number: Int
    
    var title: String {
        return "Season \(number)"
    }
}

//
//  SearchQueryModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation


struct SearchQueryModel: Codable {
    let score: Double?
    let show: ShowModel?
}
//
//struct SearchShowModel: Codable {
//    let name: String?
//    let image: SearchShowImageModel?
//    let genres: [String]?
//}
//
//struct SearchShowImageModel: Codable {
//    let medium, original: String?
//}


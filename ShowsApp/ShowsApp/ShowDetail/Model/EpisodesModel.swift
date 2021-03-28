//
//  EpisodesModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation

struct EpisodesModel: Codable {
    let id: Int?
    let name: String?
    let number: Int?
    let image: EpisodeImageModel?
    let summary: String?
}

struct EpisodeImageModel: Codable {
    let medium: String?
    let original: String?
}

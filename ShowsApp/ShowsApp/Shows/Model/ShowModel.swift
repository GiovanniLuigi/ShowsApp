//
//  ShowModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation

// MARK: - ShowModel
struct ShowModel: Codable {
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case rating, weight, network, externals, image, summary, updated, name
        case links = "_links"
    }
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String?
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, previousepisode: Previousepisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode
    }
}

// MARK: - Previousepisode
struct Previousepisode: Codable {
    let href: String?
}

// MARK: - Network
struct Network: Codable {
    let id: Int?
    let name: String?
    let country: Country?
}

// MARK: - Country
struct Country: Codable {
    let name, code, timezone: String?
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}


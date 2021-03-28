//
//  ShowModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation

struct ShowModel: Codable {
    let id: Int?
    let image: ShowImageModel?
    let name: String?
}

struct ShowImageModel: Codable {
    let medium, original: String?
}

//
//  Service.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation


protocol Service {
    var executor: Executor { get set }
}

protocol Target {
    var path: String { get }
    var method: String { get }
}

protocol Executor {
    func fetch<Model: Decodable>(_ target: Target, type: Model.Type, completion: @escaping (Result<Model, Error>) -> Void)
}



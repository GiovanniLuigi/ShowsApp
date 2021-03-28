//
//  ShowsService.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation

class ShowsService: Service {
    var executor: Executor
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func fetchShows(page: Int, completion: @escaping (Result<[ShowModel], Error>)->Void) {
        executor.fetch(ShowsAPI.shows(page:page), type: [ShowModel].self) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum ShowsAPI{
    case shows(page:Int)
    
    private var basePath: String {
        return "http://api.tvmaze.com"
    }
}

extension ShowsAPI: Target {
    var path: String {
        switch self {
        case .shows(let page):
            return "\(basePath)/shows?page=\(page)"
        }
    }
    
    var method: String {
        switch self {
        case .shows:
            return HttpMethod.get.value
        }
    }
}

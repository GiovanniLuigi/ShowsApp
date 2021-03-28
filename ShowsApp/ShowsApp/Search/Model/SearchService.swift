//
//  SearchService.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation

class SearchService: Service {
    var executor: Executor
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func fetch(query: String, completion: @escaping (Result<[SearchQueryModel], Error>)->Void) {
        executor.fetch(SearchAPI.query(query: query), type: [SearchQueryModel].self) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


enum SearchAPI {
    case query(query: String)
    
    private var basePath: String {
        return Endpoints.basePath
    }
}

extension SearchAPI: Target {
    var path: String {
        switch self {
        case .query(let query):
            return "\(basePath)/search/shows?q=\(query)"
        }
    }
    
    var method: String {
        switch self {
        case .query:
            return HttpMethod.get.value
        }
    }
}

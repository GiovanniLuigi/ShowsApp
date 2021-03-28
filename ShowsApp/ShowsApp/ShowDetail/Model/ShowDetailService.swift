//
//  ShowDetailService.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation

class ShowDetailService: Service {
    var executor: Executor
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func fetchSeasons(showID: Int, completion: @escaping (Result<[SeasonModel], Error>)->Void) {
        executor.fetch(ShowDetailAPI.seasons(showID: showID), type: [SeasonModel].self) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchEpisodes(seasonID: Int, completion: @escaping (Result<[EpisodesModel], Error>)->Void) {
        executor.fetch(ShowDetailAPI.episodes(seasonID: seasonID), type: [EpisodesModel].self) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum ShowDetailAPI {
    case seasons(showID: Int)
    case episodes(seasonID: Int)
    
    private var basePath: String {
        return Endpoints.basePath
    }
}

extension ShowDetailAPI: Target {
    var path: String {
        switch self {
        case .seasons(let showID):
            return "\(basePath)/shows/\(showID)/seasons"
        case .episodes(let seasonID):
            return "\(basePath)/seasons/\(seasonID)/episodes"
        }
    }
    
    var method: String {
        return HttpMethod.get.value
    }
}


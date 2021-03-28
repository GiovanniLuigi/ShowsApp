//
//  HttpExecutor.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation


class HttpExecutor: Executor {
    
    static let shared: HttpExecutor = HttpExecutor()
    
    private init() {}
    
    private enum NetworkError: Error, LocalizedError {
        case parsingError
        case genericError
        
        var errorDescription: String? {
            switch self {
            case .parsingError:
                return "Invalid data. We are working to solve this problem. Please try again later."
            case .genericError:
                return "An network error ocurred. Try again later."
            }
        }
    }
    
    private func doHttpRequest<Model: Codable>(_ request: URLRequest, modelType: Model.Type, completion: @escaping (Result<Model, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.genericError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.parsingError))
                }
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(modelType, from: data)
                DispatchQueue.main.async {
                    completion(.success(obj))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.parsingError))
                }
            }
        }.resume()
    }
    
    func fetch<Model: Codable>(_ target: Target, completion: @escaping (Result<Model, Error>) -> Void) {
        guard let url = URL(string: target.path) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.genericError))
            }
            return
        }
        
        let urlRequest: URLRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        doHttpRequest(urlRequest, modelType: Model.self) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

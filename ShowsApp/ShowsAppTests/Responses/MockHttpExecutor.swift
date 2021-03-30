//
//  MockHttpExecutor.swift
//  ShowsAppTests
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Foundation
@testable import ShowsApp

class MockHttpExecutor: Executor {
    
    private var fileName: String = String.empty
    private var successCode: Bool = true
    
    func fetch<Model>(_ target: Target, type: Model.Type, completion: @escaping (Result<Model, Error>) -> Void) where Model : Decodable {
        if !successCode {
            completion(.failure(NetworkError.genericError))
            return
        }
        
        guard let pathString = Bundle(for: MockHttpExecutor.self).path(forResource: fileName, ofType: "json") else {
            fatalError("\(fileName).json not found")
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert \(fileName).json to String")
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert \(fileName).json to Data")
        }
        
        if let model = try? JSONDecoder().decode(type, from: data) {
            completion(.success(model))
        } else {
            completion(.failure(NetworkError.parsingError))
        }
        
    }
    
    func register(fileName: String, successCode: Bool = true) {
        self.fileName = fileName
        self.successCode = successCode
    }

}




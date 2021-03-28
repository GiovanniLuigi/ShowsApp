//
//  ShowsService.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation

class ShowsService: Service {
    private var page: Int = 0
    var executor: Executor
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func fetchNextPage(completion: (Result<[ShowModel], Error>)->Void) {
        
    }
}

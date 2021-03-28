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
}

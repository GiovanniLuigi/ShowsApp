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
}


enum ShowDetailAPI {
    case shows(page:Int)
    
    private var basePath: String {
        return Endpoints.basePath
    }
}

extension ShowDetailAPI: Target {
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


//
//  MoreService.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Foundation

class MoreService {
    
    private var authProvider: AuthProvider
    
    init(authProvider: AuthProvider) {
        self.authProvider = authProvider
    }
    
    func hasPinEnabled() -> Bool {
        return authProvider.authEnabled()
    }

}

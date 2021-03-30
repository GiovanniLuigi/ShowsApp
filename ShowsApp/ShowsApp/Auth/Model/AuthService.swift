//
//  AuthService.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Foundation


class AuthService {
    
    private let authProvider: AuthProvider
    
    init(authProvider: AuthProvider) {
        self.authProvider = authProvider
    }
    
    func authEnabled() -> Bool {
        return authProvider.authEnabled()
    }

    func validatePin(_ pin: String, completion: @escaping (_ success: Bool) -> Void) {
        let success = authProvider.athenticate(pin: pin)
        completion(success)
    }
    
    func removePin(_ pin: String, completion: @escaping (_ success: Bool) -> Void) {
        authProvider.removePin()
        completion(true)
    }
    
    func createPin(_ pin: String, completion: @escaping (_ success: Bool) -> Void) {
        authProvider.addPin(pin: pin)
        completion(true)
    }
    
}

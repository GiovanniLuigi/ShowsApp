//
//  AuthProvider.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Security
import SwiftKeychainWrapper

final class AuthProvider {
    static let shared: AuthProvider = AuthProvider()
    
    private let pinKey: String = "pinKey#!@"
    private let keychain = KeychainWrapper.standard
    private var hasValidSession: Bool = false
    private init() {}
    
    func addPin(pin: String) {
        keychain.set(pin, forKey: pinKey)
    }
    
    func removePin() {
        keychain.remove(forKey: KeychainWrapper.Key(rawValue: pinKey))
    }
    
    func athenticate(pin: String) -> Bool {
        hasValidSession = keychain.string(forKey: pinKey) == pin
        return hasValidSession
    }
    
    func authEnabled() -> Bool {
        return keychain.hasValue(forKey: pinKey)
    }
    
    func invalidateSession() {
        hasValidSession = false
    }
    
    func isSessionValid() -> Bool {
        return (authEnabled() && hasValidSession) || !authEnabled()
    }
}

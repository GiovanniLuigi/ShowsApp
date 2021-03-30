//
//  AuthViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Foundation

protocol AuthViewDelegate {
    func didAuthenticateWithError()
    func didAuthenticateWithSuccess()
}

class AuthViewModel {
    let type: AuthType
    let coordinator: AuthCoordinator
    let service: AuthService
    let viewDelegate: AuthViewDelegate
    var isValidated: Bool
    
    init(type: AuthType, service: AuthService, viewDelegate: AuthViewDelegate, coordinator: AuthCoordinator) {
        self.type = type
        self.service = service
        self.viewDelegate = viewDelegate
        self.coordinator = coordinator
        self.isValidated = false
    }
    
    func didStop() {
        coordinator.delegate.didFinishWithError()
        coordinator.didStop()
    }
    
    func stopWithSuccess() {
        coordinator.delegate.didFinishWithSuccess()
        coordinator.stop()
    }
    
    func didInputPin(_ pin: String) {
        switch type {
        case .ceation:
            createPin(pin)
        case .removal:
            removePin(pin)
        case .verification:
            verificatePin(pin)
        }
    }
    
    private func createPin(_ pin: String) {
        service.createPin(pin, completion: didFinish(_:))
    }
    
    private func removePin(_ pin: String) {
        service.validatePin(pin) { [weak self] (success) in
            guard let self = self else { return }
            if success {
                self.service.removePin(pin, completion: self.didFinish(_:))
            } else {
                self.didFinish(false)
            }
        }
        
    }
    
    private func verificatePin(_ pin: String) {
        service.validatePin(pin, completion: didFinish(_:))
    }
    
    private func didFinish(_ success: Bool) {
        if success {
            isValidated = true
            finishWithSuccess()
        } else {
            displayError()
        }
    }
    
    private func finishWithSuccess() {
        viewDelegate.didAuthenticateWithSuccess()
    }
        
    private func displayError() {
        viewDelegate.didAuthenticateWithError()
    }
}

extension AuthViewModel {
    var title: String {
        return "Insert your pin"
    }
    
    var prefersLargeTitles: Bool {
        return false
    }
    
    var successMessage: String {
        return "Success"
    }
}

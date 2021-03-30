//
//  AuthViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import UIKit
import KAPinField

class AuthViewController: UIViewController {

    @IBOutlet weak var pinField: KAPinField!
    var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        
        pinField.keyboardType = .numberPad
        pinField.appearance.backBorderColor = .white
        pinField.properties.animateFocus = false
        pinField.properties.isSecure = true
        pinField.properties.secureToken = "*"
        pinField.properties.delegate = self
        pinField.appearance.backColor = UIColor.clear
        pinField.appearance.backBorderColor = .clear
        
        let _ = pinField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent && !viewModel.isValidated {
            viewModel.didStop()
        }
    }
}

extension AuthViewController: KAPinFieldDelegate {
    func pinField(_ field: KAPinField, didFinishWith code: String) {
        viewModel.didInputPin(code)
    }
}

extension AuthViewController: AuthViewDelegate {
    func didAuthenticateWithError() {
        pinField.text = String.empty
        pinField.animateFailure()
    }
    
    func didAuthenticateWithSuccess() {
        pinField.animateSuccess(with: viewModel.successMessage) { [weak self] in
            self?.viewModel.stopWithSuccess()
        }
    }
}

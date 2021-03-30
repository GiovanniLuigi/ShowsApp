//
//  MoreTableViewCellViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Foundation

protocol MoreTableViewCellViewModelDelegate: class {
    func didTapSwitch(completion: @escaping (Bool)->Void)
}

class MoreTableViewCellViewModel {
    let title: String
    weak var delegate: MoreTableViewCellViewModelDelegate?
    var hasPinEnabled: Bool
    
    init(title: String, hasPinEnabled: Bool, delegate: MoreTableViewCellViewModelDelegate?) {
        self.title = title
        self.hasPinEnabled = hasPinEnabled
        self.delegate = delegate
    }
    
    func didTapSwitch(completion: @escaping (Bool)->Void) {
        delegate?.didTapSwitch { [weak self] enabled in
            self?.hasPinEnabled = enabled
            completion(enabled)
        }
    }
    
    func isSwitchActive() -> Bool {
        return hasPinEnabled
    }
}

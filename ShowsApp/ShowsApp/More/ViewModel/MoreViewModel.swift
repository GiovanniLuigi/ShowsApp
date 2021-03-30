//
//  MoreViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import Foundation


class MoreViewModel {
    private var cellViewModels: [[MoreTableViewCellViewModel]] = []
    private var sections: [String] = []
    
    private let service: MoreService
    private let coordinator: MoreCoordinator
    private var switchCompletion: ((Bool)->Void)?
    
    init(service: MoreService, coordinator: MoreCoordinator) {
        self.service = service
        self.coordinator = coordinator
        
        sections.append("Privacy")
        cellViewModels.append([])
        cellViewModels[0].append(
            MoreTableViewCellViewModel(title: "Passcode", hasPinEnabled: service.hasPinEnabled(), delegate: self)
        )
    }
}

extension MoreViewModel: MoreTableViewCellViewModelDelegate {
    func didTapSwitch(completion: @escaping (Bool) -> Void) {
        self.switchCompletion = completion
        if service.hasPinEnabled() {
            coordinator.startPinRemoval(delegate: self)
        } else {
            coordinator.startPinCreation(delegate: self)
        }
    }
}

extension MoreViewModel: AuthDelegate {
    func didFinishWithError() {
        switchCompletion?(service.hasPinEnabled())
    }
    
    func didFinishWithSuccess() {
        switchCompletion?(service.hasPinEnabled())
    }
}

extension MoreViewModel {
    
    var title: String {
        return "More"
    }
    
    var prefersLargeTitles: Bool {
        return true
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return cellViewModels[section].count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MoreTableViewCellViewModel {
        return cellViewModels[indexPath.section][indexPath.row]
    }
    
    func titleForSection(at index: Int) -> String {
        return sections[index]
    }
}

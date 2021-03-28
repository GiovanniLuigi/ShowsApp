//
//  ShowDetailViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import Foundation

protocol ShowDetailViewDelegate {
    
}

class ShowDetailViewModel {
    private let coordinator: ShowsCoordinatorProtocol
    private let service: ShowDetailService
    private let viewDelegate: ShowDetailViewDelegate
    
    init(coordinator: ShowsCoordinatorProtocol, service: ShowDetailService, viewDelegate: ShowDetailViewDelegate) {
        self.coordinator = coordinator
        self.service = service
        self.viewDelegate = viewDelegate
    }
}

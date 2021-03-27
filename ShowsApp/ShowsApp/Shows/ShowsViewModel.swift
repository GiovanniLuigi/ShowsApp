//
//  ShowsViewModel.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import Foundation

class ShowsViewModel {
    private let coordinator: ShowsCoordinatorProtocol
    
    init(coordinator: ShowsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
}

extension ShowsViewModel {
    var title: String {
        return "Shows"
    }
    
    var prefersLargeTitle: Bool {
        return true
    }
    
    func numberOfItemsInSection(section: Int = 0) -> Int {
        return 32
    }
    
    func cellViewModel(_ indexPath: IndexPath) -> ShowsCollectionViewCellViewModel {
        return ShowsCollectionViewCellViewModel()
    }
    
}

//
//  ShowsCollectionViewDataSource.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import UIKit
import SkeletonView


class ShowsCollectionViewDataSource: NSObject, SkeletonCollectionViewDataSource {
    private let viewModel: ShowsViewModel
    
    init(viewModel: ShowsViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ShowsCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ShowsCollectionViewCell.self, indexPath: indexPath)
        if let cell = cell as? ShowsCollectionViewCell {
            cell.clear()
        }
        
        return cell
    }
}

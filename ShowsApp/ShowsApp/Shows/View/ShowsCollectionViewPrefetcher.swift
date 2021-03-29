//
//  ShowsCollectionViewPrefetcher.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 29/03/21.
//

import UIKit

class ShowsCollectionViewPrefetcher: NSObject, UICollectionViewDataSourcePrefetching {
    private var prefetchTasks: [Int: URLSessionDataTask] = [:]
    private let viewModel: ShowsViewModel
    
    init(viewModel: ShowsViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let task = UIImageView.preFetchImage(urlString: viewModel.cellViewModel(indexPath)?.coverImageURL ?? "") {
                prefetchTasks[indexPath.item] = task
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let task = prefetchTasks[indexPath.item] {
                task.cancel()
            }
        }
    }
}

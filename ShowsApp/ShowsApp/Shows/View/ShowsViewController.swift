//
//  ShowsViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit
import SkeletonView

class ShowsViewController: UIViewController {
    
    var viewModel: ShowsViewModel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupCollectionView()
        self.viewModel.fetchNextPage()
    }
}

extension ShowsViewController {
    private func setupView() {
        self.title = viewModel.title
        self.navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitle
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(ShowsCollectionViewCell.nib, forCellWithReuseIdentifier: ShowsCollectionViewCell.identifier)
        collectionView.isSkeletonable = true
        collectionView.showAnimatedSkeleton()
    }
}

extension ShowsViewController: ShowsViewDelegate {
    func didFetchShowsWithSuccess() {
        collectionView.reloadData()
        collectionView.hideSkeleton()
    }
    
    func didFetchShowsWithError() {
        print(viewModel.errorMessage)
    }
}

extension ShowsViewController: SkeletonCollectionViewDataSource {
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

extension ShowsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cellViewModel = viewModel.cellViewModel(indexPath), let cell = cell as? ShowsCollectionViewCell {
            cell.configure(viewModel: cellViewModel)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ShowsCollectionViewCell {
            cell.clear()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCell(at: indexPath)
    }
}

extension ShowsViewController: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
        let cell = collectionView.dequeue(ShowsCollectionViewCell.self, indexPath: indexPath)
        if let cellViewModel = viewModel.cellViewModel(indexPath), let cell = cell as? ShowsCollectionViewCell {
            cell.configure(viewModel: cellViewModel)
        }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
        let cell = collectionView.dequeue(ShowsCollectionViewCell.self, indexPath: indexPath)
        if let cell = cell as? ShowsCollectionViewCell {
            cell.clear()
        }
    }
  }
}

extension ShowsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width/3.0) - 32
        let height = width * 1.76
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 24, bottom: 24, right: 24)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

extension ShowsViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.isLoading {
            return
        }
        
        let offset = -200
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge + CGFloat(offset) >= scrollView.contentSize.height) {
            viewModel.fetchNextPage()
        }
    }
}

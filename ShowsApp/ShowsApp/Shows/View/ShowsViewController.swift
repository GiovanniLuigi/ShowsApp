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
    var collectionViewDelegate: ShowsCollectionViewDelegate!
    var collectionViewDataSource: ShowsCollectionViewDataSource!
    var collectionViewPrefetcher: ShowsCollectionViewPrefetcher!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideLoadingIndicator(animated: false)
        self.setupView()
        self.setupCollectionView()
        self.viewModel.fetchNextPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitle
    }
}

extension ShowsViewController {
    private func setupView() {
        self.title = viewModel.title
    }
    
    private func setupCollectionView() {
        collectionView.showAnimatedSkeleton()
        collectionViewDelegate =  ShowsCollectionViewDelegate(viewModel: viewModel)
        collectionViewDataSource = ShowsCollectionViewDataSource(viewModel: viewModel)
        collectionViewPrefetcher = ShowsCollectionViewPrefetcher(viewModel: viewModel)
        
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.prefetchDataSource = collectionViewPrefetcher
        collectionView.register(ShowsCollectionViewCell.nib, forCellWithReuseIdentifier: ShowsCollectionViewCell.identifier)
        collectionView.isSkeletonable = true
        collectionView.isPrefetchingEnabled = true
    }
}

extension ShowsViewController: ShowsViewDelegate {
    func didFetchShowsWithSuccess() {
        hideLoadingIndicator( completion: { [weak self] in
            self?.collectionView.reloadData()
            self?.collectionView.hideSkeleton()
        })
    }
    
    func didFetchShowsWithError() {
        print(viewModel.errorMessage)
    }
}

extension ShowsViewController {
    private func hideLoadingIndicator(animated: Bool = true, completion: (()->Void)? = nil) {
        animateLoadingIndicator(value: 0, isHidden: true, animated: animated, completion: completion)
    }
    
    private func showLoadingIndicator(animated: Bool = true, completion: (()->Void)? = nil) {
        animateLoadingIndicator(value: 75, isHidden: false, animated: animated, completion: completion)
    }
    
    private func animateLoadingIndicator(value: CGFloat, isHidden: Bool, animated: Bool, completion: (()->Void)? = nil) {
        loadingIndicatorHeightConstraint.constant = value
        if animated {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.activityView.isHidden = isHidden
                self?.view.layoutIfNeeded()
            } completion: { (_) in
                completion?()
            }
            
        } else {
            view.layoutIfNeeded()
            activityView.isHidden = isHidden
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.isLoading {
            return
        }
        
        let offset = -100
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge + CGFloat(offset) >= scrollView.contentSize.height) {
            showLoadingIndicator { [weak self] in
                self?.viewModel.fetchNextPage()
            }
        }
    }
}

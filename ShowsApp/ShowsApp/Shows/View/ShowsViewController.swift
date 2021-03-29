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
        
        collectionViewDataSource = ShowsCollectionViewDataSource(viewModel: viewModel)
        collectionViewPrefetcher = ShowsCollectionViewPrefetcher(viewModel: viewModel)
        
        collectionView.delegate = self
        collectionView.dataSource = collectionViewDataSource
        collectionView.prefetchDataSource = collectionViewPrefetcher
        collectionView.register(ShowsCollectionViewCell.nib, forCellWithReuseIdentifier: ShowsCollectionViewCell.identifier)
        collectionView.isSkeletonable = true
        collectionView.isPrefetchingEnabled = true
        
        collectionView.showAnimatedSkeleton()
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
        let canCancel = viewModel.numberOfItemsInSection() > 0
        presentErrorMessage(message: viewModel.errorMessage, canCancel: canCancel) { [weak self] in
            self?.viewModel.fetchNextPage()
        }
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
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.activityView.isHidden = isHidden
                self?.view.layoutIfNeeded()
            } completion: { (_) in
                completion?()
            }
            
        } else {
            activityView.isHidden = isHidden
            view.layoutIfNeeded()
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



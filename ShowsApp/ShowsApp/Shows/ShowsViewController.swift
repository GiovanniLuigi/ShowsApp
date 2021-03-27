//
//  ShowsViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

class ShowsViewController: UIViewController {
    
    var viewModel: ShowsViewModel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupCollectionView()
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
        collectionView.register(ShowsCollectionViewCell.nib, forCellWithReuseIdentifier: ShowsCollectionViewCell.identifier)
    }
}

extension ShowsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.cellViewModel(indexPath)
        return collectionView.dequeue(ShowsCollectionViewCell.self, indexPath: indexPath, viewModel: cellViewModel)
    }
}

extension ShowsViewController: UICollectionViewDelegate {


}

extension ShowsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width/3.0) - 32
        let height = width * 1.76
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 24, bottom: 24, right: 24)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}

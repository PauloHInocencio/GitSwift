//
//  ViewController.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import UIKit

class RepositoriesVC: UICollectionViewController {
    var store: GitStore!
    let dataSorce = GitRepositoryDataSource()
    var myActivityIndicator:UIActivityIndicatorView!
    var fetchingMore = true


    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupActivityView()
        setupRefreshControl()
        loadData()
    }
    
    
    func setupCollectionView() {
        collectionView?.alwaysBounceVertical = true
        collectionView?.dataSource = dataSorce

    }
    
    func setupActivityView() {
        myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = true
        collectionView?.addSubview(myActivityIndicator)
    }
    
    func loadData() {
        myActivityIndicator.startAnimating()

        fetchingMore = true
        store.getRepositories {
            (result) -> Void in
            let lastIndex = self.dataSorce.repositories.count
            
            self.myActivityIndicator.stopAnimating()

            self.fetchingMore = false
            
            switch result {
            case let .success(repositories):
                self.dataSorce.repositories.insert(contentsOf: repositories, at: lastIndex)
            case .failure(_):
                self.dataSorce.repositories.removeAll()
                
            }
            self.collectionView?.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    


}

//MARK - Collection Layout Handler

extension RepositoriesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if fetchingMore {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }
    
    
    
}








//MARK - UIScrollView Delegate
extension RepositoriesVC {
    
    func setupRefreshControl () {
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                                     action: #selector(refreshOptions(sender:)),
                                     for: .valueChanged)
            collectionView?.refreshControl = refreshControl
        }
    }
    
    
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        store.currentPage = 1
        store.getRepositories {
            (result) -> Void in
            
            sender.endRefreshing()
            
            switch result {
            case let .success(repositories):
                self.dataSorce.repositories.removeAll()
                self.dataSorce.repositories = repositories
            case .failure(_):
                self.dataSorce.repositories.removeAll()
                
            }
            self.collectionView?.reloadData()
        }
        
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                loadData()
            }
            
        }
    }
}






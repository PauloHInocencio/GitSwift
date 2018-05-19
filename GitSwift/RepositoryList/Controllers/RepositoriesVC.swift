//
//  ViewController.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesVC: UICollectionViewController {
    
    let cellID = "repositoryCell"
    let footerID = "footerID"
    var store: RxGitStore!
    var repositories = [GitRepository]()
    var myActivityIndicator:UIActivityIndicatorView!
    var fetchingMore = true
    let dispose = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupActivityView()
        setupRefreshControl()
        loadData()
    }
    
    func setupCollectionView() {
        collectionView?.alwaysBounceVertical = true
        let nibReusableView = UINib(nibName: "ActivityIndicatorFooterView", bundle: nil)
        collectionView?.register(nibReusableView, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerID)

    }
    
    func setupActivityView() {
        myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = true
        collectionView?.addSubview(myActivityIndicator)
    }
    
    func loadData() {
        fetchingMore = true
        myActivityIndicator.startAnimating()

        store.getRepositories()
            .drive(onNext: { repos in
                self.fetchingMore = false
                self.myActivityIndicator.stopAnimating()
                
                let lastIndex = self.repositories.count
                self.repositories.insert(contentsOf: repos, at: lastIndex)
                self.collectionView?.reloadData()
                
            })
            .disposed(by: dispose)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}




//MARK: - CollectionView Data Source

extension RepositoriesVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RepositoryCell
        cell.repository = repositories[indexPath.item]
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath)
        return footer
    }
}


//MARK: - Collection Layout Delegate

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


//MARK: - UIScrollView Delegate
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
        store.currentPage = 0
        store.getRepositories()
            .drive(onNext: { repos in
                sender.endRefreshing()
                self.repositories.removeAll()
                self.repositories = repos
                self.collectionView?.reloadData()
            }).disposed(by: dispose)
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






//
//  GitRepositoryDataSource.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 26/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import UIKit

class GitRepositoryDataSource: NSObject, UICollectionViewDataSource {
    let cellID = "repositoryCell"
    var repositories = [GitRepository]()

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RepositoryCell
        cell.repository = repositories[indexPath.item]
        return cell
    
    }
    

    
    
    
}

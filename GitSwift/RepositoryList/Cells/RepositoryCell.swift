//
//  RepositoryCell.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 26/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryCell: UICollectionViewCell {
    
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositoryForkCount: UILabel!
    @IBOutlet weak var repositoryStarsCount: UILabel!
    @IBOutlet weak var repositoryForkIcon: UIImageView! {
        didSet {
            repositoryForkIcon.image = UIImage(named: "git_icon_fork")?.withRenderingMode(.alwaysTemplate)
            repositoryForkIcon.tintColor = UIColor(hex: "1E6262")
        }
    }
    @IBOutlet weak var repositoryStarsIcon: UIImageView! {
        didSet {
            repositoryStarsIcon.image = UIImage(named: "git_icon_star")?.withRenderingMode(.alwaysTemplate)
            repositoryStarsIcon.tintColor = UIColor(hex: "1E6262")
        }
    }
    
    @IBOutlet weak var repositoryOwnerLogin: UILabel!
    @IBOutlet weak var repositoryOwnerInfo: UILabel!
    @IBOutlet weak var repositoryOwnerPhoto: UIImageView! {
        didSet {
            repositoryOwnerPhoto.layer.cornerRadius = 10
            repositoryOwnerPhoto.layer.masksToBounds = true
        }
    }
    
    
    var repository: GitRepository? {
        didSet {
            if let repository = repository {
                
                repositoryName.text = repository.name
                repositoryDescription.text = repository.description
                repositoryForkCount.text = "\(repository.forks_count!)"
                repositoryStarsCount.text = "\(repository.stargazers_count!)"
                repositoryOwnerLogin.text = repository.owner!.login
                
                repositoryOwnerPhoto.sd_setImage(with: URL(string: repository.owner!.avatar_url!), placeholderImage: #imageLiteral(resourceName: "git_user_place_holder"))
                
            
                
                
            }
        }
    }
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    

    
}

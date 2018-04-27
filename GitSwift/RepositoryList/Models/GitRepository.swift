//
//  Repository.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

struct GitRepository: Decodable, Comparable {

    let name:String
    let description:String?
    let forks_count:Int?
    let stargazers_count:Int?
    let owner:GitRepositoryOwner?
    
    

    
    static func == (lhs: GitRepository, rhs: GitRepository) -> Bool {
       return lhs.name == rhs.name
    }
    
    static func < (lhs: GitRepository, rhs: GitRepository) -> Bool {
        return lhs.stargazers_count! > rhs.stargazers_count!
    }
    
}

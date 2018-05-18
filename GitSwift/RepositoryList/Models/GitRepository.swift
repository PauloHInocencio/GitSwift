//
//  Repository.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

struct GitRepository: Decodable, Comparable {

    var name:String
    var description:String?
    var forks_count:Int?
    var stargazers_count:Int?
    var owner:GitRepositoryOwner?
    
    
    init() {
        self.name = ""
        self.description = nil
        self.forks_count = nil
        self.stargazers_count = nil
        self.owner = nil
    }
    
    static func == (lhs: GitRepository, rhs: GitRepository) -> Bool {
       return lhs.name == rhs.name
    }
    
    static func < (lhs: GitRepository, rhs: GitRepository) -> Bool {
        return lhs.stargazers_count! > rhs.stargazers_count!
    }
    
}

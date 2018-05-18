//
//  RepositoryOwner.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

struct GitRepositoryOwner:Decodable {
    var login:String
    var name:String?
    var type:String?
    var bio:String?
    var avatar_url:String?
    
     init() {
        login = ""
        name = nil
        type = nil
        bio = nil
        avatar_url = nil
        
    }
}

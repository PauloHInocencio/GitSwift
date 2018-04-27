//
//  RepositoryOwner.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

struct GitRepositoryOwner:Decodable {
    let login:String
    let name:String?
    let type:String?
    let bio:String?
    let avatar_url:String?
}

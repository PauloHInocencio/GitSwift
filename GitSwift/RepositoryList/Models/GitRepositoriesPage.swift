//
//  RepositoriesResponse.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 26/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

struct GitRepositoriesPage:Decodable {
    let items: [GitRepository]
}

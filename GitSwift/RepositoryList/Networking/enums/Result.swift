//
//  Result.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}



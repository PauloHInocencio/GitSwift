//
//  NetworkProtocol.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import UIKit

protocol NetworkService {

    func get(_ url: URL,
                    completion: @escaping (Result<Data>) -> Void) -> Void
    
    func getImage(_ url: URL,
             completion: @escaping (Result<UIImage>) -> Void) -> Void
}

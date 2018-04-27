//
//  NetworkClient.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class HttpAlamofireClient: NetworkService {
    func get(_ url: URL, completion: @escaping (Result<Data>) -> Void) {
        Alamofire
            .request(url, method: .get)
            .responseJSON { (response) in
                if response.result.isSuccess, let data = response.data  {
                    completion(.success(data))
                } else {
                    completion(.failure(AppError.serverError))
                }
        }
    }
    
    func getImage(_ url: URL, completion: @escaping (Result<UIImage>) -> Void) {
        Alamofire
            .request(url, method: .get)
            .response { (response) in
                guard
                    let imageData = response.data,
                    let image = UIImage(data: imageData) else {
                        if response.data == nil {
                            completion(.failure(AppError.serverError))
                        } else {
                            completion(.failure(AppError.parsingDataError))
                        }
                        return
                }
                
                completion(.success(image))
        }
    }
    
    
    
}


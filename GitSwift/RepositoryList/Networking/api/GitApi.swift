//
//  GitApi.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

private enum EndPoint: String {
    case searchRepositories = "search/repositories"
    case serchUsers = "users"
}

struct GitApi {
    private static let baseURLString = "https://api.github.com/"
    
    private static func gitURL(_ endPoint: String, parameters: [String: String]?) -> URL? {
        var components = URLComponents(string: "\(baseURLString)\(endPoint)")!
        var queryItems = [URLQueryItem]()
        
        if let addtionalParams = parameters {
            for (key, value) in addtionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            
            components.queryItems = queryItems
        }
        
        
        return components.url
    }

    
    static func getSearchRepositoriesURL(page:Int = 1) -> URL? {
        return gitURL(EndPoint.searchRepositories.rawValue, parameters: ["q" : "language:Swift",
                                                                  "sort" : "stars",
                                                                  "page" : "\(page)"])
    }
    
    static func getReposioryOwnerInfosURL(login:String) -> URL? {
        let endPoint:String = "\(EndPoint.serchUsers.rawValue)/\(login)"
        return gitURL(endPoint, parameters: nil)
    }
    
    
    
}

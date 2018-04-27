//
//  GitApiTest.swift
//  GitSwiftTests
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import XCTest
@testable import GitSwift

class GitApiTest: XCTestCase {
    
    
    
    func test_if_api_return_valid_url_to_repositories() {
        let expectedUrlString:String = "https://api.github.com/search/repositories?q=language:Swift&page=1&sort=stars"
        
        guard let url = GitApi.getSearchRepositoriesURL(page: 1) else {
            fatalError("Bad url error!")
        }
        
        XCTAssertEqual(url.absoluteString, expectedUrlString)
    }
    
    
    func test_if_api_return_valid_url_to_owner() {
        let expectedUrlString:String = "https://api.github.com/users/userlogin"
        guard let url = GitApi.getReposioryOwnerInfosURL(login: "userlogin") else {
            fatalError("Bad url error!")
        }
        
        XCTAssertEqual(url.absoluteString, expectedUrlString)
    }
    
    
}

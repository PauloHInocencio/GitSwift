//
//  RepositoryStoreTest.swift
//  GitSwiftTests
//
//  Created by Paulo Inocencio on 26/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import XCTest
@testable import GitSwift

class GitStoreTest: XCTestCase {
    
    let gitstore = GitStore()
    
    override func setUp() {
        super.setUp()
        gitstore.webservice = HttpAlamofireClient()
        
    }
    
    func test_if_store_return_data() {
        let requestAnswered = expectation(description: "GetGitRepositories")
        
        var repositores:[GitRepository]?
        
        gitstore.getRepositories { (result) in
            switch result {
            case let .success(data):
                repositores = data
            case .failure(_):
                print("Failed to get respositories")
            }
            
            XCTAssertNotNil(repositores)
            XCTAssertEqual(repositores?.count, 30)
            requestAnswered.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func test_if_store_return_more_data() {
        let requestAnswered = expectation(description: "GetGitRepositories")
        
        var repositories_1:[GitRepository] = []
        var repositories_2:[GitRepository] = []
        
        gitstore.getRepositories { (result) in
            switch result {
            case let .success(data1):
                repositories_1 = data1
            case .failure(_):
                fatalError("Failed to get respositories")
            }
            
            self.gitstore.getRepositories { (resuls2) in
                switch resuls2 {
                case let .success(data2):
                    repositories_2 = data2
                case .failure(_):
                    fatalError("Failed to get respositories")
                }
                
                let sameReturn = repositories_1.containsSameElements(as: repositories_2)
                XCTAssertEqual(false, sameReturn)
                requestAnswered.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func test_if_store_return_empty_array_when_hit_the_limite_page() {
        
        let requestAnswered = expectation(description: "GetGitRepositories")
        
        var repositores:[GitRepository]?
        
        gitstore.currentPage = 35
        
        gitstore.getRepositories { (result) in
            switch result {
            case let .success(data):
                repositores = data
            case .failure(_):
                print("Failed to get respositories")
            }
            
            XCTAssertNotNil(repositores)
            XCTAssertEqual(repositores?.count, 0)
            requestAnswered.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        
    }
    

    
 
    
}

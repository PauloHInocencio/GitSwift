//
//  RxGitStoreTest.swift
//  GitSwiftTests
//
//  Created by Paulo Inocencio on 16/05/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking
import RxCocoa
@testable import GitSwift

class RxGitStoreTest: XCTestCase {
    
    let gitstore = RxGitStore()
    let dispose:DisposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
       
    }
    
    func test_if_store_returns_data() {
        
        let repositories = try! gitstore.getRepositories().toBlocking().toArray().first
        
        XCTAssertNotNil(repositories)
        XCTAssertEqual(repositories?.count, 30)
        
    }
    
    func test_if_store_returns_more_data() {
        

        let repositories_1 = try! gitstore.getRepositories().asObservable().toBlocking().toArray().first
        let repositories_2 = try! gitstore.getRepositories().asObservable().toBlocking().toArray().first
        
         guard
            let repo1 = repositories_1,
            let repo2 = repositories_2 else {
                XCTFail("Failed with error")
                return
        }
    
        let sameReturn =  repo1.isEmpty && repo1.containsSameElements(as: repo2)
        XCTAssertEqual(false, sameReturn)
        
        
        

     
    }
    
    func test_if_store_returns_empty_array_when_hits_the_limit_page() {
        /* let requestAnswered = expectation(description: "GetGitRepositories")
        
        var repositories:[GitRepository]?
        
        gitstore.currentPage = 35
        
        gitstore.getRepositories()
            .drive(onNext: { repos in
                repositories = repos
                requestAnswered.fulfill()
            })
            .disposed(by: dispose)
        
        waitForExpectations(timeout: 5) { (_) in
            XCTAssertNotNil(repositories)
            XCTAssertEqual(repositories?.count, 0)
        } */
        
        
        
    }
}

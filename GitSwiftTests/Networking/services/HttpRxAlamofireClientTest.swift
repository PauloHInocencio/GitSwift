//
//  RepositoriesServiceTest.swift
//  GitSwiftTests
//
//  Created by Paulo Inocencio on 11/05/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking


@testable import GitSwift


class HttpRxAlamofireClientTest: XCTestCase {
    
    
    
    private let service = HttpRxAlamofireClient()
    //private let disposable = DisposeBag()

    
    
    func test_if_request_return_with_success() {
        
        let result = service.fetchRepositories(onPage: 0)
        .toBlocking()
        .materialize()
        
        switch result {
            case .completed(let elements):
                XCTAssertEqual(elements.count, 1)
            case .failed(_, let error):
                XCTFail("Expected result to complete without error, but received \(error)")
        }
    }
    
    func test_if_request_return_30_repositories()  {
        do {
            let result = try service
                .fetchRepositories(onPage: 0)
                .toBlocking()
                .toArray()
            
            XCTAssertEqual(result.first!.count, 30)
        } catch  {
            XCTFail("Failed with error")
        }

    }
    
    func test_if_request_return_repository_owner_biography() {
        
        var biographiesCount:Int = 0
        
        let result = service.fetchRepositories(onPage: 0)
        .toBlocking()
        .materialize()
        
        switch result {
        case .completed(elements: let elements):
            elements.first?.forEach { repos in
                if repos.owner?.bio != nil {
                    biographiesCount += 1
                }
            }
        case .failed(_, let error):
            XCTFail("Expected result to complete without error, but received \(error)")
        }
        

        XCTAssertTrue(biographiesCount > 0, "Expected that the number of owner biographies was greater than zero.")
    }
    
   
    func test_if_request_return_repository_owner_full_name() {
        
        var namesCount:Int = 0
        
        let result = service.fetchRepositories(onPage: 0)
            .toBlocking()
            .materialize()
        
        switch result {
        case .completed(elements: let elements):
            elements.first?.forEach { repos in
                if repos.owner?.name != nil {
                    namesCount += 1
                }
            }
        case .failed(_, let error):
            XCTFail("Expected result to complete without error, but received \(error)")
        }
        
        
        XCTAssertTrue(namesCount > 0, "Expected that the number of owner names was greater than zero.")
    }
    
    
    

    
    
}

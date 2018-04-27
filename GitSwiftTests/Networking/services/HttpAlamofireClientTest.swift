//
//  NetworkingTest.swift
//  GitSwiftTests
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import XCTest
@testable import GitSwift


class HttpAlamofireClientTest: XCTestCase {
    
    var webservice:NetworkService!
    var url:URL!
    var repositoriesPage:GitRepositoriesPage?
    
    override func setUp() {
        super.setUp()
        webservice = HttpAlamofireClient()
        url = URL(string: "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1")!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_if_the_request_for_repositories_return_success() {
        let requestAnswered = expectation(description: "Repositories")
        
        webservice.get(url) { (response) in
            var success:Bool = false
            
            switch response {
                case .success(_):
                    success = true
                case .failure(_):
                    success = false
            }
            
            XCTAssertTrue(success)
            requestAnswered.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func test_if_request_result_can_be_parsing_into_respository() {
        
        let requestAnswered = expectation(description: "Repositories")
        var success:Bool = false

        webservice.get(url) { (response) in
            
            switch response {
                case let .success(data):
                    do {
                        self.repositoriesPage = try JSONDecoder().decode(GitRepositoriesPage.self, from: data)
                        success = true
                    } catch let jsonError {
                        print("Failed to decode: \(jsonError.localizedDescription)")
                    }
                case .failure(_):
                    success = false
            }
            
            XCTAssertTrue(success)
            XCTAssertNotNil(self.repositoriesPage)
            XCTAssertEqual(self.repositoriesPage?.items.count, 30)
            
            requestAnswered.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
    }
    
    
    
    func test_if_the_request_for_repo_owner_return_success() {
        let requestAnswered = expectation(description: "Repositories")
        guard let _url = GitApi.getReposioryOwnerInfosURL(login: "Ramotion") else {
            fatalError("Bad url error!")
        }
        
        webservice.get(_url) { (response) in
            
            var success:Bool = false
            
            switch response {
            case .success(_):
                success = true
            case .failure(_):
                success = false
            }
            
            XCTAssertTrue(success)
            requestAnswered.fulfill()
            
        }
        
   
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func test_if_request_result_can_be_parsing_into_repo_owner() {
        
        let requestAnswered = expectation(description: "Repositories")
        guard let _url = GitApi.getReposioryOwnerInfosURL(login: "Ramotion") else {
            fatalError("Bad url error!")
        }
        var owner:GitRepositoryOwner?
        
        var success:Bool = false
        
        webservice.get(_url) { (response) in
            
            switch response {
            case let .success(data):
                do {
                    owner = try JSONDecoder().decode(GitRepositoryOwner.self, from: data)
                    success = true
                } catch let jsonError {
                    print("Failed to decode: \(jsonError.localizedDescription)")
                }
            case .failure(_):
                success = false
            }
            
            XCTAssertTrue(success)
            XCTAssertNotNil(owner)
            XCTAssertEqual(owner?.login, "Ramotion")
            XCTAssertEqual(owner?.type!, "Organization")
            
            requestAnswered.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
    }
    
    func test_if_the_request_for_repo_owner_image_return_success() {
        let requestAnswered = expectation(description: "Repositories")
        guard let _url = GitApi.getReposioryOwnerInfosURL(login: "Ramotion") else {
            fatalError("Bad url error!")
        }
        
        var owner:GitRepositoryOwner?
        var image:UIImage?
        
        
        webservice.get(_url) { (response) in
            
            switch response {
                case let .success(data):
                    do {
                        owner = try JSONDecoder().decode(GitRepositoryOwner.self, from: data)
                    } catch let jsonError {
                        print("Failed to decode: \(jsonError.localizedDescription)")
                    }
                case let .failure(serverError):
                    print("Server conection fail : \(serverError.localizedDescription)")
            }
            
            guard
                let image_url_string = owner?.avatar_url,
                let image_url = URL(string: image_url_string) else {
                    fatalError("Bad url error!")
            }
            
            self.webservice.getImage(image_url) { (imageResponse) in
                
                switch imageResponse {
                case let .success(_image):
                    image = _image
                case let .failure(parsingError):
                    print("Failed to decode: \(parsingError.localizedDescription)")
                }
                
                XCTAssertNotNil(image)
                requestAnswered.fulfill()
                
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }

}

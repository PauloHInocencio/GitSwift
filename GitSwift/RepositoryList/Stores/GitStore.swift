//
//  RepositoryStore.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 25/04/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation

class GitStore {
    var currentPage:Int = 1
    var webservice:NetworkService!
    
    func getRepositories(completion: @escaping (Result<[GitRepository]>) -> Void) {
        guard let url = GitApi.getSearchRepositoriesURL(page: currentPage) else {
            completion(Result.failure(AppError.badUrlError))
            return
        }
        
        webservice.get(url) { (result) in
            switch result {
            case let .success(data):
                OperationQueue.main.addOperation {
                    completion(self.parseGitRepositories(from: data))
                }
                
            case let .failure(e):
                completion(Result.failure(e))
            }
        }
    }
    
    
    private func parseGitRepositories(from data: Data) -> Result<[GitRepository]> {
        do {
            let repositoriesResponse = try JSONDecoder().decode(GitRepositoriesPage.self, from: data)
            self.currentPage += 1
            return Result.success(repositoriesResponse.items)
        } catch {
            return parseGitServerMessage(from: data)
        }
    }
    
    
    private func parseGitServerMessage(from data: Data) -> Result<[GitRepository]> {
        do {
            let serverMessage = try JSONDecoder().decode(GitServerMessage.self, from: data)
            if serverMessage.message == "Only the first 1000 search results are available" {
               return Result.success([GitRepository]())
            }
            return Result.failure(AppError.serverError)
        } catch {
            return Result.failure(AppError.parsingDataError)
        }
    }
    
    
    
    
    
}

//
//  RepositoriesService.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 11/05/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import RxAlamofire
import RxCocoa
import RxSwift

struct HttpRxAlamofireClient {
    
    func fetchRepositories(onPage page:Int) -> Observable<[GitRepository]> {
        return RxAlamofire
            .requestData(.get, GitApi.getSearchRepositoriesURL(page: page)!)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map( { (arg) -> Observable<GitRepository> in
                let (_, data) = arg
                do {
                    let gitpage = try JSONDecoder().decode(GitRepositoriesPage.self, from: data)
                    return Observable.from(gitpage.items)
                }
            })
            .flatMap {
                return $0
            }
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { repository -> Observable<GitRepository> in
                return self.fetchOwnersInfo(repository)
            }
            .flatMap {
                return $0
            }
            .toArray()
            .catchErrorJustReturn([])
            .asObservable()
    }
    
    func fetchOwnersInfo( _ repository:GitRepository ) -> Observable<GitRepository> {
        var repos = repository
        return RxAlamofire
            .requestData(.get, GitApi.getReposioryOwnerInfosURL(login: repository.owner!.login)!)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map ({ arg -> GitRepository in
                let (_, data) = arg
                do {
                    let gitOwner = try JSONDecoder().decode(GitRepositoryOwner.self, from: data)
                    repos.owner = gitOwner
                    return repos
                }
            })
            .catchErrorJustReturn(GitRepository())
    }
    
}

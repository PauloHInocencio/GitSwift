//
//  RxGitStore.swift
//  GitSwift
//
//  Created by Paulo Inocencio on 16/05/18.
//  Copyright © 2018 Poul Apps. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxGitStore {
    var currentPage:Int = 0;
    private let currentPageVariable = BehaviorSubject(value: 0)
    private var repositoriesObserver:Observable<[GitRepository]>!
    
    init() {
        self.repositoriesObserver =
            currentPageVariable.asObservable()
            .flatMap(HttpRxAlamofireClient().fetchRepositories)
    }
    
    func getRepositories() -> Driver<[GitRepository]> {
        currentPage += 1
        currentPageVariable.onNext(currentPage)
        return self.repositoriesObserver.asDriver(onErrorJustReturn: [])
    }

}

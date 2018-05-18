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
    //private let webservice = HttpRxAlamofireClient()
    //private var completionHandler:((Result<[GitRepository]>) -> Void)? = nil
    //private let disposeBag = DisposeBag()

    
    init() {
        self.repositoriesObserver =
            currentPageVariable.asObservable()
            .flatMap(HttpRxAlamofireClient().fetchRepositories)
        
        /*.subscribe({ result in
            
            
            guard let completion = self.completionHandler else {
                return
            }
            
            guard let repositories = result.element else {
                completion(Result.failure(AppError.serverError))
                return
            }
            
            completion(Result.success(repositories))
            self.completionHandler = nil
        })
        .disposed(by: disposeBag)*/
    }
    
    func getRepositories() -> Driver<[GitRepository]> {
        currentPage += 1
        currentPageVariable.onNext(currentPage)
        return self.repositoriesObserver.asDriver(onErrorJustReturn: [])
    }

}

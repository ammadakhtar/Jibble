//
//  FetchRocketsUseCase.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
import RxSwift

protocol FetchRocketsUseCaseProtocol: AnyObject {
    func execute() -> Observable<[Rocket]>
}

final class FetchRocketsUseCase: FetchRocketsUseCaseProtocol {
    private let rocketsRepository: RocketsRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(rocketsRepository: RocketsRepositoryProtocol) {
        self.rocketsRepository = rocketsRepository
    }
    
    // MARK: - FetchShowsUseCaseProtocol
    
    /// Executes the given useCase of fetching the shows
    ///
    func execute() -> Observable<[Rocket]> {
        return Observable.create { [weak self] observer in
            self?.rocketsRepository.fetchRockets()
                .subscribe { event in
                    switch event {
                    case .next(let rockets):
                        observer.onNext(rockets)
                        observer.onCompleted()
                    case .error(let error):
                        observer.onError(error)
                    case .completed:
                        break
                    }
                }.disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
}

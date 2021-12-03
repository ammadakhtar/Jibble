//
//  FetchRocketUseCase.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
import RxSwift

protocol FetchRocketUseCaseProtocol: AnyObject {
    func execute(id: String) -> Observable<[RocketDetail]>
}

final class FetchRocketUseCase: FetchRocketUseCaseProtocol {
    private let rocketRepository: RocketRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(rocketRepository: RocketRepositoryProtocol) {
        self.rocketRepository = rocketRepository
    }
    
    // MARK: - FetchShowsUseCaseProtocol
    
    /// Executes the given useCase of fetching the shows
    ///
    func execute(id: String) -> Observable<[RocketDetail]> {
        return Observable.create { [weak self] observer in
            self?.rocketRepository.fetchRocketById(id: id)
                .subscribe { event in
                    switch event {
                    case .next(let rocketDetails):
                        observer.onNext(rocketDetails)
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

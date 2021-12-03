//
//  RocketLaunchesRepository.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
import RxSwift

protocol RocketsRepositoryProtocol: AnyObject {
    func fetchRockets() -> Observable<[Rocket]>
}

final class RocketsRepository: RocketsRepositoryProtocol {
    
    // MARK: - Variables

    private let networkService: NetworkService
        
    // MARK: - Init
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches the shows from the available dataSource
    ///
    func fetchRockets() -> Observable<[Rocket]> {
        // If we would have had offline database here we would have had another function that fetches data from coredata/Realm
        // thats why we have a separate function to fetch from internet
        return Observable.create { observer in
            self.fetchRocketsFromInternet { result in
                switch result {
                case .success(let rockets):
                    observer.onNext(rockets)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    /// Fetches the shows from the internet
    ///
    private func fetchRocketsFromInternet(complete completion: @escaping (Result<[Rocket], Error>) -> Void) {
        networkService.request(RocketsRequest()) { result in
            switch result {
            case .success(let rockets):
                completion(.success(rockets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

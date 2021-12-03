//
//  RocketRepository.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
import RxSwift

protocol RocketRepositoryProtocol: AnyObject {
    func fetchRocketById(id: String) -> Observable<[RocketDetail]>
}

final class RocketRepository: RocketRepositoryProtocol {
    
    // MARK: - Variables

    private let networkService: NetworkService
        
    // MARK: - Init
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches the shows from the available dataSource
    ///
    func fetchRocketById(id: String) -> Observable<[RocketDetail]> {
        // If we would have had offline database here we would have had another function that fetches data from coredata/Realm
        // thats why we have a separate function to fetch from internet
        return Observable.create { observer in
            self.fetchRocketFromInternet(id: id) { result in
                switch result {
                case .success(let rocketDetails):
                    observer.onNext(rocketDetails)
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
    private func fetchRocketFromInternet(id: String, complete completion: @escaping (Result<[RocketDetail], Error>) -> Void) {
        networkService.request(RocketRequest(id: id)) { result in
            switch result {
            case .success(let rocketDetails):
                completion(.success(rocketDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

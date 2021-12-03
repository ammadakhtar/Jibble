//
//  RocketDetailListDIContainer.swift
//  Jibble
//
//  Created by Umair Afzal on 03/12/2021.
//

import UIKit
import SafariServices

final class RocketDetailDIContainer {
    
    struct Dependencies {
        let networkService: NetworkService
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - UseCases
    
    private func fetchRocketUseCase() -> FetchRocketUseCaseProtocol {
        return FetchRocketUseCase(rocketRepository: makeRocketRepository())
    }
    
    // MARK: - Repository
    
    private func makeRocketRepository() -> RocketRepositoryProtocol {
        return RocketRepository(networkService: dependencies.networkService)
    }
    
    // MARK: - ViewModel
    
    private func makeFetchRocketDetailViewModel(rocketId: String) -> FetchRocketViewModel {
        return FetchRocketViewModel(rocketId: rocketId, fetchRocketUseCase: fetchRocketUseCase())
    }
    
    // MARK: - ViewController
    
    func makeRocketDetailViewController(id: String, coordinator: RocketDetailCoordinator) -> RocketDetailVC {
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RocketDetailVC") as! RocketDetailVC
        let networkService = DefaultNetworkService()
        let rocketRepository = RocketRepository(networkService: networkService)
        let fetchRocketUseCase = FetchRocketUseCase(rocketRepository: rocketRepository)
        detailsVC.coordinator = coordinator
        detailsVC.viewModel = FetchRocketViewModel(rocketId: id, fetchRocketUseCase: fetchRocketUseCase)
        return detailsVC
    }
}

//
//  RocketLaunchesListDIContainer.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import UIKit

final class RocketLaunchesListDIContainer {
    
    struct Dependencies {
        let networkService: NetworkService
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - UseCases
    
    private func fetchRocketsUseCase() -> FetchRocketsUseCaseProtocol {
        return FetchRocketsUseCase(rocketsRepository: makeRocketsRepository())
    }
    
    // MARK: - Repository
    
    private func makeRocketsRepository() -> RocketsRepositoryProtocol {
        return RocketsRepository(networkService: dependencies.networkService)
    }
    
    // MARK: - ViewModel
    
    private func makeFetchRocketLaunchesViewModel() -> FetchRocketsViewModel {
        return FetchRocketsViewModel(fetchRocketsUseCase: fetchRocketsUseCase())
    }
    
    // MARK: - ViewController
    
    func makeRocketLaunchesListViewController(coordinator: MainCoordinator) -> RocketLaunchesListVC {
        let rocketLaunchListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rocketLaunchListVC") as! RocketLaunchesListVC
        rocketLaunchListVC.viewModel = makeFetchRocketLaunchesViewModel()
        rocketLaunchListVC.coordinator = coordinator
        return rocketLaunchListVC
    }
}

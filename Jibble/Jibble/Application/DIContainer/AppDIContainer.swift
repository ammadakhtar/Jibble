//
//  AppDIContainer.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation

final class AppDIContainer {
    
    lazy var networkService: NetworkService = {
       return DefaultNetworkService()
    }()
    
    func makeRocketLaunchesListDIContainer() -> RocketLaunchesListDIContainer {
        let dependencies = RocketLaunchesListDIContainer.Dependencies(networkService: networkService)
        return RocketLaunchesListDIContainer(dependencies: dependencies)
    }
    
    func makeRocketDetailDIConatiner() -> RocketDetailDIContainer {
        let dependencies = RocketDetailDIContainer.Dependencies(networkService: networkService)
        return RocketDetailDIContainer(dependencies: dependencies)
    }
}

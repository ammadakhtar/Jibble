//
//  MainCoordinator.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    enum Destination {
        case details(id: String)
    }
    
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    private var rocketDetailCoordinator: RocketDetailCoordinator!

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        navigationController.isNavigationBarHidden = true
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.rocketDetailCoordinator = RocketDetailCoordinator(navigationController: navigationController, rocketDetailDIContainer: appDIContainer.makeRocketDetailDIConatiner())
    }

    // Starts the flow of the application
    func start() {
        let rocketLaunchesListDIContainer = appDIContainer.makeRocketLaunchesListDIContainer()
        let rocketLaunchesListViewController = rocketLaunchesListDIContainer.makeRocketLaunchesListViewController(coordinator: self)
        navigationController.pushViewController(rocketLaunchesListViewController, animated: false)
    }

    // pops ViewController
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func push(to destination: Destination) {
        
    }
    
    func present(destination: Destination) {
        
        switch destination {
        case .details (let id):
            let rocketDetailDIContainer = appDIContainer.makeRocketDetailDIConatiner()
            let rocketDetailViewController = rocketDetailDIContainer.makeRocketDetailViewController(id: id, coordinator: rocketDetailCoordinator)
            navigationController.present(rocketDetailViewController, animated: true)
        }
    }
}

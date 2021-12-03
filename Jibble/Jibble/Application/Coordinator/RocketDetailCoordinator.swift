//
//  RocketDetailCoordinator.swift
//  Jibble
//
//  Created by Umair Afzal on 03/12/2021.
//

import UIKit

final class RocketDetailCoordinator: Coordinator {
    
    enum Destination {
        case wikipedia(url: String)
    }
    
    var navigationController: UINavigationController
    var rocketDetailDIContainer: RocketDetailDIContainer
    
    init(navigationController: UINavigationController, rocketDetailDIContainer: RocketDetailDIContainer) {
        navigationController.isNavigationBarHidden = true
        self.navigationController = navigationController
        self.rocketDetailDIContainer = rocketDetailDIContainer
    }

    // Starts the flow of the application
    func start() {
    }

    // pops ViewController
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func push(to destination: Destination) {
        
    }
    
    func present(destination: Destination) {
        
        switch destination {
        case .wikipedia(let url):
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

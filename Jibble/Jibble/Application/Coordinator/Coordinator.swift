//
//  Coordinator.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation

protocol Coordinator {
    func start()
    
    associatedtype Destination
    func push(to destination: Destination)
    func present(destination: Destination)
}

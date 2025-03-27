//
//  Coordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/19/25.
//

import UIKit

@MainActor
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var router: Router { get }
    
    func start()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}


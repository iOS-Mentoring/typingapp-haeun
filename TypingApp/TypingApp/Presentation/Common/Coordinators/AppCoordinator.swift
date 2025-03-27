//
//  AppCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/19/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var router: Router
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .gray200
        window.rootViewController = navigationController
        
        self.router = Router(navigationController: navigationController)
    }
    
    func start() {
        let mainCoordinator = TypingCoordinator(router: router)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
        window.makeKeyAndVisible()
    }
}

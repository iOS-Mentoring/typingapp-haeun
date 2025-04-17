//
//  HomeCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/17/25.
//

import UIKit

final class HomeCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewController = HomeViewController()
        router.show(viewController, style: .push)
    }
}

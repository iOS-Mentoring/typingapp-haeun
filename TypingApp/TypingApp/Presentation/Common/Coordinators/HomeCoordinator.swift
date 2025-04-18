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
        let viewModel = HomeViewModel()
        viewModel.coordinator = self
        let viewController = HomeViewController(viewModel: viewModel)
        router.show(viewController, style: .push)
    }
    
    func showTypingView() {
        let typingCoordinator = TypingCoordinator(router: router)
        childCoordinators.append(typingCoordinator)
        typingCoordinator.start()
    }
}

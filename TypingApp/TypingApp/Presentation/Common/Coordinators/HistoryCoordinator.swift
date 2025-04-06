//
//  HistoryCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/24/25.
//

import UIKit

final class HistoryCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        //let viewModel = HistoryViewModel()
        //viewModel.coordinator = self
        let viewController = HistoryViewController()
        router.show(viewController, style: .push)
    }
}

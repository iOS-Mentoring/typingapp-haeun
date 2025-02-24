//
//  HistoryCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/24/25.
//

import UIKit

final class HistoryCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //let viewModel = HistoryViewModel()
        //viewModel.coordinator = self
        let viewController = HistoryViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}

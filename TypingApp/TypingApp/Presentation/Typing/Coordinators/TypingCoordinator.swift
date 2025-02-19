//
//  TypingCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/19/25.
//

import UIKit

final class TypingCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = TypingViewModel()
        viewModel.coordinator = self
        let viewController = TypingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showLinkWebView() {
        let linkWebViewCoordinator = LinkWebViewCoordinator(navigationController: navigationController)
        addChildCoordinator(linkWebViewCoordinator)
        linkWebViewCoordinator.parentCoordinator = self
        linkWebViewCoordinator.start()
    }
}

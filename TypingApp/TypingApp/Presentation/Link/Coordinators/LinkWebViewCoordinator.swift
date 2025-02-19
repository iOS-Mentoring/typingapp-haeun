//
//  LinkWebViewCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/19/25.
//

import UIKit

final class LinkWebViewCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: (any Coordinator)?
    
    init(navigationController: UINavigationController) {
        self .navigationController = navigationController
    }
    
    func start() {
        let webViewModel = LinkWebViewViewModel()
        webViewModel.coordinator = self
        let linkWebViewController = LinkWebViewController(viewModel: webViewModel)
        linkWebViewController.modalPresentationStyle = .pageSheet
        navigationController.present(linkWebViewController, animated: true)
    }
}

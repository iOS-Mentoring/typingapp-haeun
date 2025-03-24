//
//  TypingCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/19/25.
//

import UIKit

final class TypingCoordinator: NSObject, Coordinator {
    let navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let viewModel = TypingViewModel()
        viewModel.coordinator = self
        let viewController = TypingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentLinkWebView() {
        let webViewModel = LinkWebViewViewModel()
        let linkWebViewController = LinkWebViewController(viewModel: webViewModel)
        linkWebViewController.modalPresentationStyle = .pageSheet
        navigationController.present(linkWebViewController, animated: true)
    }
    
    func presentCompleteView() {
        let viewModel = CompleteViewModel()
        let viewController = CompletePopupViewController(viewModel: viewModel)
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.modalPresentationStyle = .overFullScreen
        navigationController.present(navVC, animated: true)
    }
    
    func showHistoryView() {
        let historyCoordinator = HistoryCoordinator(navigationController: navigationController)
        historyCoordinator.parentCoordinator = self
        childCoordinators.append(historyCoordinator)
        historyCoordinator.start()
    }
}

extension TypingCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        if let _ = fromViewController as? HistoryViewController {
            //removeChildCoordinator()
            print("remove historycoordinator")
        }
    }
}

//
//  TypingCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/19/25.
//

import UIKit

final class TypingCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewModel = TypingViewModel(timerUseCase: TimerUseCaseImpl(), textProcessingUseCase: TextProcessingUseCaseImpl(), fetchTypingTextUseCase: FetchTypngTextUseCaseImpl(repository: TypingTextRepositoryImpl()))
        viewModel.coordinator = self
        let viewController = TypingViewController(viewModel: viewModel)
        
        router.push(viewController: viewController, animated: true, backButton: false)
    }
    
    func presentLinkWebView() {
        let webViewModel = LinkWebViewViewModel()
        let linkWebViewController = LinkWebViewController(viewModel: webViewModel)
        linkWebViewController.modalPresentationStyle = .pageSheet
        router.present(viewController: linkWebViewController, animated: true, completion: nil)
    }
    
    func presentCompleteView() {
        let viewModel = CompleteViewModel()
        let viewController = CompletePopupViewController(viewModel: viewModel)
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.modalPresentationStyle = .overFullScreen
        router.present(viewController: navVC, animated: true, completion: nil)
    }
    
    func showHistoryView() {
        let historyCoordinator = HistoryCoordinator(router: router)
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

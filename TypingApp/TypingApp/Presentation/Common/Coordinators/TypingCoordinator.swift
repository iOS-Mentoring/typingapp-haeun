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
        let viewModel = TypingViewModel(timerUseCase: TimerUseCase(), textProcessingUseCase: TextProcessingUseCase(), fetchTypingTextUseCase: FetchTypngTextUseCase(repository: TypingRepository()))
        viewModel.coordinator = self
        let viewController = TypingViewController(viewModel: viewModel)
        
        router.show(viewController, style: .push)
    }
    
    func presentLinkWebView() {
        let webViewModel = LinkWebViewViewModel()
        let linkWebViewController = LinkWebViewController(viewModel: webViewModel)
        linkWebViewController.modalPresentationStyle = .pageSheet
        router.show(linkWebViewController, style: .present)
    }
    
    func presentCompleteView() {
        let viewModel = CompleteViewModel()
        let viewController = CompletePopupViewController(viewModel: viewModel)
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.modalPresentationStyle = .overFullScreen
        router.show(navVC, style: .present)
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

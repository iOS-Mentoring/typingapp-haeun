//
//  TabBarCoordinator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/16/25.
//

import UIKit

final class TabBarCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let tabBarController = UITabBarController()
        
        let historyNavigationController = UINavigationController()
        let homeNavigationController = UINavigationController()
        let myPageNavigationController = UINavigationController()
        
        let historyCoordinator = HistoryCoordinator(router: Router(navigationController: historyNavigationController))
        childCoordinators.append(historyCoordinator)
        historyNavigationController.tabBarItem = UITabBarItem(title: "하루보관함", image: .btnHistoryLine, tag: 0)
        childCoordinators.append(historyCoordinator)
        historyCoordinator.start()
        
        let homeCoordinator = TypingCoordinator(router: Router(navigationController: homeNavigationController))
        childCoordinators.append(homeCoordinator)
        homeNavigationController.tabBarItem = UITabBarItem(title: "홈", image: .btnHomePre, tag: 1)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
        tabBarController.viewControllers = [historyNavigationController, homeNavigationController]
        
        router.show(tabBarController, style: .push)
    }
    
    private func setupTabBar(_ tabBarController: UITabBarController) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        // 탭바 배경색 설정 (원하는 색상으로 변경 가능)
        appearance.backgroundColor = .systemBackground
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
    }
}

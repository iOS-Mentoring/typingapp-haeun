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
        setupTabBar(tabBarController)
        
        let historyNavigationController = UINavigationController()
        let homeNavigationController = UINavigationController()
        let myPageNavigationController = UINavigationController()
        
        let historyCoordinator = HistoryCoordinator(router: Router(navigationController: historyNavigationController))
        childCoordinators.append(historyCoordinator)
        historyNavigationController.tabBarItem = UITabBarItem(title: "하루보관함", image: .btnHistoryLine, tag: 0)
        childCoordinators.append(historyCoordinator)
        historyCoordinator.start()
        
        let homeCoordinator = HomeCoordinator(router: Router(navigationController: homeNavigationController))
        childCoordinators.append(homeCoordinator)
        homeNavigationController.tabBarItem = UITabBarItem(title: "홈", image: .btnHomePre, tag: 1)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
        let myPageCoordinator = MyPageCoordinator(router: Router(navigationController: myPageNavigationController))
        childCoordinators.append(myPageCoordinator)
        myPageNavigationController.tabBarItem = UITabBarItem(title: "마이페이지", image: .btnMyNor, tag: 2)
        childCoordinators.append(myPageCoordinator)
        myPageCoordinator.start()
        
        tabBarController.viewControllers = [historyNavigationController, homeNavigationController, myPageNavigationController]
        
        router.show(tabBarController, style: .push)
    }
    
    private func setupTabBar(_ tabBarController: UITabBarController) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryEmphasis
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(hexCode: "#666666")
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexCode: "#666666") ?? .gray300]
        appearance.stackedLayoutAppearance.selected.iconColor = .inversePrimaryEmphasis
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.inversePrimaryEmphasis]
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
    }
}

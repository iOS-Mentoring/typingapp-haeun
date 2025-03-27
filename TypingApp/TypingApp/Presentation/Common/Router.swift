//
//  Router.swift
//  TypingApp
//
//  Created by Haeun Kwon on 3/27/25.
//

import UIKit

@MainActor
protocol RouterProtocol: AnyObject {
    func push(viewController: UIViewController, animated: Bool, backButton: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

final class Router: RouterProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationBar()
    }
    
    func push(viewController: UIViewController, animated: Bool, backButton: Bool = true) {
        backButton ? setupBackButton(to: viewController) : ()
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
}

extension Router {
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .inversePrimaryEmphasis
        appearance.shadowColor = .inversePrimaryEmphasis
        
        appearance.titleTextAttributes = [
            .font: UIFont.nanumMyeongjo(type: .bold, size: 22),
            .foregroundColor: UIColor(hexCode: "111111") ?? UIColor.primaryEmphasis
        ]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupBackButton(to viewController: UIViewController) {
        let action = UIAction { _ in
            self.pop(animated: true)
        }
        let closeButton = UIBarButtonItem(image: .iconLeftArrow, primaryAction: action)
        viewController.navigationItem.leftBarButtonItem = closeButton
    }
}

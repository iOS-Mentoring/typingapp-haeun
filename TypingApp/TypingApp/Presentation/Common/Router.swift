//
//  Router.swift
//  TypingApp
//
//  Created by Haeun Kwon on 3/27/25.
//

import UIKit

enum PresentationStyle {
    case push
    case present
}

@MainActor
protocol RouterProtocol: AnyObject {
    func show(_ viewController: UIViewController, style: PresentationStyle)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

final class Router: RouterProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationBar()
    }
    
    func show(_ viewController: UIViewController, style: PresentationStyle) {
        switch style {
        case .push:
            if !navigationController.viewControllers.isEmpty {
                setupBackButton(to: viewController)
            }
            navigationController.pushViewController(viewController, animated: true)
        case .present:
            navigationController.present(viewController, animated: true)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated, completion: completion)
        } else {
            navigationController.popViewController(animated: animated)
        }
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
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func setupBackButton(to viewController: UIViewController) {
        let action = UIAction { _ in
            self.dismiss(animated: true)
        }
        let closeButton = UIBarButtonItem(image: .iconLeftArrow, primaryAction: action)
        viewController.navigationItem.leftBarButtonItem = closeButton
    }
}

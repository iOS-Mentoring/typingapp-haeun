//
//  BaseViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/7/25.
//

import UIKit

class BaseViewController: UIViewController {
    let navigationBar = CustomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(navigationBar, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .height(60)])
    }
}

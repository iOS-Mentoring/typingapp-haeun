//
//  BaseViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/7/25.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray200
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .inversePrimaryEmphasis
        appearance.shadowColor = .inversePrimaryEmphasis
        
        appearance.titleTextAttributes = [
            .font: UIFont.nanumMyeongjo(type: .bold, size: 22),
            .foregroundColor: UIColor(hexCode: "111111") ?? UIColor.primaryEmphasis
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(image: .iconLeftArrow,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

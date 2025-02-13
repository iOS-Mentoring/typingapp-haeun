//
//  CompletePopupViewController.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/13/25.
//

import UIKit
import Combine

class CompletePopupViewController: BaseViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .crumpledWhitePaper
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    private let gradientView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = gradientView.bounds
    }
    
    private func setupNavigation() {
        let closeButton = UIBarButtonItem(
            image: .iconClose,
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.rightBarButtonItem = closeButton
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .white

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView, autoLayout: [.topSafeArea(-224), .leadingSafeArea(-354), .height(1084), .width(1084)])
        view.addSubview(gradientView, autoLayout: [.topSafeArea(0), .leadingSafeArea(0), .trailingSafeArea(0), .height(74)])
        gradientView.layer.addSublayer(gradientLayer)
    }
}

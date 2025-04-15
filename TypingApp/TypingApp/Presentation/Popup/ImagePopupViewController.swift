//
//  ImagePopupViewController.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/9/25.
//

import UIKit

final class ImagePopupViewController: UIViewController {
    private let contentStackView = UIStackView()
    private let imageView = UIImageView()
    
    private let buttonView = UIView()
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("오늘 하루 보지 않기", for: .normal)
        button.setTitleColor(UIColor(hexCode: "#999999"), for: .normal)
        button.titleLabel?.font = .pretendard(type: .medium, size: 14)
        return button
    }()
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.primaryEmphasis, for: .normal)
        button.titleLabel?.font = .pretendard(type: .semiBold, size: 14)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        modalTransitionStyle = .crossDissolve
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = .crumpledWhitePaper
        if let image = imageView.image {
            let ratio = image.size.height / image.size.width
            imageView.autoLayout([.aspectRatio(ratio)])
        }
        
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(buttonView)
        contentStackView.layer.cornerRadius = 10
        contentStackView.clipsToBounds = true
        contentStackView.axis = .vertical
        contentStackView.backgroundColor = .inversePrimaryEmphasis
        
        buttonView.autoLayout([.height(60)])
        view.addSubview(contentStackView, autoLayout: [.leading(30), .trailing(30), .centerY(0)])
        
        buttonView.addSubview(skipButton, autoLayout: [.leading(30), .centerY(0)])
        buttonView.addSubview(closeButton, autoLayout: [.trailing(30), .centerY(0)])
    }
}

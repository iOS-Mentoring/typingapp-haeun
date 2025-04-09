//
//  TextPopupViewController.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/8/25.
//

import UIKit

final class TextPopupViewController: UIViewController {
    
    private let contentStackView = UIStackView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 15)
        label.textAlignment = .center
        label.textColor = .primaryEmphasis
        label.numberOfLines = 0
        
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 21
        style.maximumLineHeight = 21
        style.paragraphSpacing = 4
        style.alignment = .center
        label.attributedText = NSAttributedString(
            string: "원본 문구에 대한\n자세한 정보를 알고 싶으신가요?",
            attributes: [
                .paragraphStyle: style,
                .font: UIFont.pretendard(type: .regular, size: 15)
            ])
        return label
    }()
    
    private let buttonStackView = UIStackView()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("오늘 하루 보지 않기", for: .normal)
        button.setTitleColor(UIColor(hexCode: "#999999"), for: .normal)
        button.titleLabel?.font = .pretendard(type: .medium, size: 14)
        return button
    }()
    
    private let openButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("열기", for: .normal)
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
        
        let divider = UIView()
        divider.backgroundColor = .gray_divider
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(divider)
        contentStackView.addArrangedSubview(buttonStackView)
        contentStackView.layer.cornerRadius = 10
        contentStackView.clipsToBounds = true
        contentStackView.axis = .vertical
        contentStackView.backgroundColor = .inversePrimaryEmphasis
        
        titleLabel.autoLayout([.height(126)])
        divider.autoLayout([.height(1)])
        buttonStackView.autoLayout([.height(60)])
        view.addSubview(contentStackView, autoLayout: [.leading(30), .trailing(30), .centerY(0)])
        
        let verticalDivider = UIView()
        verticalDivider.backgroundColor = .gray_divider
        
        buttonStackView.addArrangedSubview(skipButton)
        buttonStackView.addArrangedSubview(verticalDivider)
        buttonStackView.addArrangedSubview(openButton)
        buttonStackView.distribution = .fill
        
        verticalDivider.autoLayout([.width(1)])
        skipButton.autoLayout([.widthEqual(to: openButton, constant: 1)])
    }
}

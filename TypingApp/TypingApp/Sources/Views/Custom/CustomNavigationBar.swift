//
//  CustomNavigationView.swift
//  TypingApp
//
//  Created by 권하은 on 2/7/25.
//

import UIKit

class CustomNavigationBar: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .nanumMyeongjo(type: .bold, size: 22)
        label.textColor = .primaryEmphasis
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel, autoLayout: [.center(0)])
        addSubview(leftButton, autoLayout: [.centerY(0), .leading(16)])
        addSubview(rightButton, autoLayout: [.centerY(0), .trailing(16)])
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setLeftButton(image: UIImage?) {
        leftButton.setImage(image, for: .normal)
    }
    
    func setRightButton(image: UIImage?) {
        rightButton.setImage(image, for: .normal)
    }
    
    func setLeftButtonAction(_ action: @escaping () -> Void) {
        leftButton.addAction(UIAction { _ in action() }, for: .touchUpInside)
    }
    
    func setRightButtonAction(_ action: @escaping () -> Void) {
        rightButton.addAction(UIAction { _ in action() }, for: .touchUpInside)
    }
}

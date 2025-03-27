//
//  TypingInputAccessoryView.swift
//  TypingApp
//
//  Created by 권하은 on 2/8/25.
//

import UIKit

final class TypingInputAccessoryView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .semiBold, size: 13)
        label.textColor = .primaryEmphasis
        label.text = "불안한 사람들"
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 11)
        label.textColor = .primaryEmphasis
        label.text = "프레드릭 베크만"
        return label
    }()
    
    private let linkButton: UIButton = {
        let button = UIButton()
        button.setImage(.iconLink, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 56))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .gray200
        
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
        borderLayer.backgroundColor = .primaryEmphasis
        layer.addSublayer(borderLayer)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        
        addSubview(stackView, autoLayout: [.leading(20), .centerY(0)])
        addSubview(linkButton, autoLayout: [.trailing(20), .centerY(0)])
    }
    
    func setLinkButtonAction(_ action: UIAction) {
        linkButton.addAction(action, for: .touchUpInside)
    }
}

//
//  NavigationButton.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/18/25.
//

import UIKit

final class NavigationButton: UIButton {
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: .iconArrowThin)
        return imageView
    }()
    private let customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 16)
        label.textColor = .inversePrimaryEmphasis
        return label
    }()
    private let stackView = UIStackView()
    
    private let customImageView = UIImageView()
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        self.customTitleLabel.text = title
        customImageView.image = image
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .primaryEmphasis
        
        stackView.isUserInteractionEnabled = false
        stackView.addArrangedSubview(customTitleLabel)
        stackView.addArrangedSubview(arrowImageView)
        addSubview(stackView, autoLayout: [.top(20), .leading(20)])
        
        addSubview(customImageView, autoLayout: [.trailing(20), .bottom(20), .height(48), .width(48)])
    }
}

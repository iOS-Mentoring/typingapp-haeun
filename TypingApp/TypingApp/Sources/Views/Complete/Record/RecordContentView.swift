//
//  RecordContentView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/14/25.
//

import UIKit

class RecordContentView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 11)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .bold, size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(titleText: String, contentText: String) {
        self.init(frame: .zero)
        configure(titleText: titleText, contentText: contentText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView, autoLayout: [.top(0), .bottom(0), .leading(0), .trailing(0)])
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
    }
    
    private func configure(titleText: String, contentText: String) {
        titleLabel.text = titleText
        contentLabel.text = contentText
        if titleText == "ACC" {
            let attributedString = NSMutableAttributedString(string: contentText + "%")
            attributedString.addAttribute(.font, value: UIFont.pretendard(type: .bold, size: 14), range: NSRange(location: contentText.count, length: 1))
            contentLabel.attributedText = attributedString
        }
    }
}

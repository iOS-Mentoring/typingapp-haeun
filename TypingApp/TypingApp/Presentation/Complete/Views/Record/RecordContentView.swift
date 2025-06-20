//
//  RecordContentView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/14/25.
//

import UIKit

final class RecordContentView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 11)
        label.textColor = .primaryEmphasis
        label.textAlignment = .center
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .bold, size: 20)
        label.textColor = .primaryEmphasis
        label.textAlignment = .center
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryEmphasis
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(titleText: String, isLastItem: Bool = false) {
        self.init(frame: .zero)
        titleLabel.text = titleText
        separateView.isHidden = isLastItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView, autoLayout: [.top(0), .bottom(0), .leading(0), .trailing(0)])
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        
        addSubview(separateView, autoLayout: [.centerY(0), .height(35), .width(0.5), .trailing(0)])
    }
    
    func configure(content contentText: String) {
        contentLabel.text = contentText
        if titleLabel.text == "ACC" {
            let attributedString = NSMutableAttributedString(string: contentText + "%")
            attributedString.addAttribute(.font, value: UIFont.pretendard(type: .bold, size: 14), range: NSRange(location: contentText.count, length: 1))
            contentLabel.attributedText = attributedString
        }
    }
}

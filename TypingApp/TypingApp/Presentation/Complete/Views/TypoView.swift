//
//  TypoView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/14/25.
//

import UIKit

final class TypoView: UIView {
    private let doubleQuotesImageView: UIImageView = {
        let imageView = UIImageView(image: .iconDoubleQuotes)
        return imageView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .semiBold, size: 16)
        label.textColor = .primaryEmphasis
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 12)
        label.textColor = .primaryEmphasis
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextViewAttributedText(text: String, isEmpty: Bool) {
        let style = NSMutableParagraphStyle()
        let lineheight = 28.0
        style.minimumLineHeight = lineheight
        style.maximumLineHeight = lineheight
        textView.attributedText = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: style,
                .font: UIFont.pretendard(type: .regular, size: 18),
                .foregroundColor: isEmpty ? UIColor(hexCode: "#000000", alpha: 0.5) ?? .primaryEmphasis : .primaryEmphasis
            ])
    }
    
    private func setupUI() {
        addSubview(doubleQuotesImageView, autoLayout: [.top(0), .leading(0), .height(24), .width(24)])
        addSubview(textView, autoLayout: [.topNext(to: doubleQuotesImageView, constant: 20), .leading(0), .trailing(0)])
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        addSubview(stackView, autoLayout: [.leading(0), .bottom(0), .topNext(to: textView, constant: 30)])
    }
    
    func configure(typo: String, title: String?, author: String?) {
        setTextViewAttributedText(text: typo, isEmpty: title == nil)
        titleLabel.text = title
        authorLabel.text = author
    }
}

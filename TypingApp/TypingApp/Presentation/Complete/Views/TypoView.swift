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
        let text = "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
        
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        
        let style = NSMutableParagraphStyle()
        let lineheight = 28.0
        style.minimumLineHeight = lineheight
        style.maximumLineHeight = lineheight
        
        textView.attributedText = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: style
            ])
        textView.font = .pretendard(type: .regular, size: 18)
        
        textView.backgroundColor = .clear
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
        label.text = "불안한 사람들"
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 12)
        label.textColor = .primaryEmphasis
        label.text = "프레드릭 베크만"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(doubleQuotesImageView, autoLayout: [.top(0), .leading(0), .height(24), .width(24)])
        addSubview(textView, autoLayout: [.topNext(to: doubleQuotesImageView, constant: 20), .leading(0), .trailing(0)])
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        addSubview(stackView, autoLayout: [.leading(0), .bottom(0), .topNext(to: textView, constant: 30)])
    }
}

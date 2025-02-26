//
//  HistoryContentView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/26/25.
//

import UIKit

final class HistoryContentView: UIView {
    private let recordView = RecordView()
    private let typoView = TypoView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(stackView, autoLayout: [.top(0), .leading(0), .trailing(0)])
        stackView.addArrangedSubview(recordView)
        stackView.addArrangedSubview(typoView)
        recordView.autoLayout([.height(88)])
    }
}

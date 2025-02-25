//
//  DayCell.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/25/25.
//

import UIKit

final class DayCell: UICollectionViewCell {
    static let reuseIdentifier = "DayCell"
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .bold, size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let selectionIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let typingIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryEmphasis
        view.layer.cornerRadius = 2
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(selectionIndicator, autoLayout: [.top(0), .leading(0), .trailing(0), .aspectRatio(1)])
        selectionIndicator.addSubview(dayLabel, autoLayout: [.center(0)])
        addSubview(typingIndicator, autoLayout: [.centerY(0), .topNext(to: selectionIndicator, constant: 5), .width(4), .height(4)])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectionIndicator.backgroundColor = .clear
        typingIndicator.isHidden = true
    }
}

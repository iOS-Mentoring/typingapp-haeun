//
//  TypingSpeedView.swift
//  TypingApp
//
//  Created by 권하은 on 2/7/25.
//

import UIKit

class TypingSpeedView: UIView {
    
    private let wpmLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .light, size: 13)
        label.textColor = .white
        
        let text = "WPM "
        let number = "0"
        
        let attributedString = NSMutableAttributedString(string: text + number)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .bold), range: NSRange(location: text.count, length: number.count))
        label.attributedText = attributedString
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 13)
        label.textColor = .white
        
        return label
    }()
    
    private let gageView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryRed
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        backgroundColor = UIColor.primaryEmphasis
        //addSubview(gageView, autoLayout: [.leading(0), .top(0), .bottom(0), .width(80)])
        addSubview(wpmLabel, autoLayout: [.leading(20), .centerY(0)])
        addSubview(timeLabel, autoLayout: [.trailing(20), .centerY(0)])
    }
    
    func updateTimeLabel(_ text: String) {
        timeLabel.text = text
    }
}

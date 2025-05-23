//
//  DayCell.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/25/25.
//

import UIKit

final class DayCell: UICollectionViewCell {
    static let reuseIdentifier = "DayCell"
    
    private let weekdaySymbolLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 10)
        label.textAlignment = .center
        return label
    }()
    
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
        addSubview(weekdaySymbolLabel, autoLayout: [.top(20), .centerX(0)])
        addSubview(selectionIndicator, autoLayout: [.topNext(to: weekdaySymbolLabel, constant: 11), .height(30), .width(30), .centerX(0)])
        selectionIndicator.addSubview(dayLabel, autoLayout: [.center(0)])
        addSubview(typingIndicator, autoLayout: [.centerX(0), .topNext(to: selectionIndicator, constant: 5), .width(4), .height(4)])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectionIndicator.backgroundColor = .clear
        typingIndicator.isHidden = true
    }
    
    func configure(with day: CalendarDay) {
        weekdaySymbolLabel.text = day.weekdayText
        weekdaySymbolLabel.textColor = weekdaySymbolLabel.text == "Sun" ? .primaryRed : .primaryEmphasis
        dayLabel.text = day.date.formattedDateString(dateFormat: "dd")
        
        //setSelected()
        typingIndicator.isHidden = !day.hasTypingResult
    }
    
    func setSelected(_ selected: Bool) {
        selectionIndicator.backgroundColor = selected ? .gray100 : .clear
    }
}

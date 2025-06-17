//
//  RecordView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/14/25.
//

import UIKit

final class RecordView: UIStackView {
    private let wpmRecordView = RecordContentView(titleText: "WPM")
    private let accRecordView = RecordContentView(titleText: "ACC")
    private let dateRecordView = RecordContentView(titleText: "Date", isLastItem: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorders(edges: [.top, .bottom], color: .primaryEmphasis, width: 1)
    }
    
    private func setupUI() {
        axis = .horizontal
        alignment = .center
        distribution = .fill
        autoLayout([.height(88)])
        
        let recordViews = [wpmRecordView, accRecordView, dateRecordView]
        recordViews.forEach { addArrangedSubview($0) }
        recordViews.forEach { view in
            if view != wpmRecordView {
                view.autoLayout([.widthEqual(to: wpmRecordView, constant: 0)])
            }
        }
    }
    
    func configureRecord(wpm: Int, acc: Int, date: Date) {
        wpmRecordView.configure(content: String(wpm))
        accRecordView.configure(content: String(acc))
        dateRecordView.configure(content: date.formattedDateString(dateFormat: "MMM dd"))
    }
}

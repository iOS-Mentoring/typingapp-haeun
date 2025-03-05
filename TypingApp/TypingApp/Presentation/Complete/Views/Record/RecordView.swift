//
//  RecordView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/14/25.
//

import UIKit

final class RecordView: UIStackView {
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
        let wpmRecordView = RecordContentView(titleText: "WPM", contentText: "0")
        let accRecordView = RecordContentView(titleText: "ACC", contentText: "0")
        let dateRecordView = RecordContentView(titleText: "Date", contentText: "0", isLastItem: true)
        
        let recordViews = [wpmRecordView, accRecordView, dateRecordView]
        recordViews.forEach { addArrangedSubview($0) }
        recordViews.forEach { view in
            if view != wpmRecordView {
                view.autoLayout([.widthEqual(to: wpmRecordView, constant: 0)])
            }
        }
    }
}

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
    
    private let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 40))
    
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
    }
    
    func configure(with day: DayModel) {
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        if day.hasTypingResult {
            stackView.addArrangedSubview(recordView)
            stackView.addArrangedSubview(typoView)
            typoView.configure(
                text: "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.",
                title: "불안한 사람들",
                author: "프레드릭 베크만"
            )
        } else {
            stackView.addArrangedSubview(emptyView)
            stackView.addArrangedSubview(typoView)
            typoView.configure(
                text: "하루가 기다리고 있어요!\n얼른 필사하며 하루를 쌓아보세요!",
                title: "",
                author: ""
            )
        }
    }
}

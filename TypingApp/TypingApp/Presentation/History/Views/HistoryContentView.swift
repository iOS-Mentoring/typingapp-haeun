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
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .crumpledWhitePaper
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.alignment = .leading
        return stackView
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(.iconDownload, for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(.iconShare, for: .normal)
        return button
    }()
    
    private let buttonStackView = UIStackView()
    
    private let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 40))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backgroundImageView, autoLayout: [.top(0), .leadingSafeArea(-354), .height(1084), .width(1084)])
        addSubview(stackView, autoLayout: [.top(20), .leading(0), .trailing(0)])
        
        buttonStackView.addArrangedSubview(downloadButton)
        buttonStackView.addArrangedSubview(shareButton)
        buttonStackView.spacing = 8
        downloadButton.autoLayout([.width(36), .height(36)])
        shareButton.autoLayout([.width(36), .height(36)])
    }
    
    func configure(with day: DayModel) {
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        if day.hasTypingResult {
            stackView.addArrangedSubview(recordView)
            recordView.autoLayout([.widthEqual(to: stackView, constant: 0)])
            stackView.addArrangedSubview(typoView)
            typoView.configure(with: TypoInfo(
                text: "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.",
                title: "불안한 사람들",
                author: "프레드릭 베크만"
            ))
            stackView.addArrangedSubview(buttonStackView)
        } else {
            stackView.addArrangedSubview(emptyView)
            stackView.addArrangedSubview(typoView)
            typoView.configure(with: TypoInfo.empty)
        }
    }
}

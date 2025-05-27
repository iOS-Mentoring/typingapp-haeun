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
        
        stackView.addArrangedSubview(recordView)
        recordView.autoLayout([.widthEqual(to: stackView, constant: 0)])
        stackView.addArrangedSubview(emptyView)
        stackView.addArrangedSubview(typoView)
        stackView.addArrangedSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(downloadButton)
        buttonStackView.addArrangedSubview(shareButton)
        buttonStackView.spacing = 8
        downloadButton.autoLayout([.width(36), .height(36)])
        shareButton.autoLayout([.width(36), .height(36)])
    }
    
    func configureWithRecord(_ record: Record) {
        recordView.isHidden = false
        emptyView.isHidden = true
        buttonStackView.isHidden = false
        
        recordView.configureRecord(
            wpm: record.wpm,
            acc: record.acc,
            date: record.date
        )
        
        typoView.configure(
            typo: record.typing,
            title: record.title,
            author: record.author
        )
    }
    
    func configureEmpty() {
        recordView.isHidden = true
        emptyView.isHidden = false
        buttonStackView.isHidden = true
        
        typoView.configure(
            typo: "필사된 정보가 없습니다.",
            title: nil,
            author: nil
        )
    }
    
    
}

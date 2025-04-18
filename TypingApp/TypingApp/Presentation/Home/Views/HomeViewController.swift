//
//  HomeViewController.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/17/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .nanumMyeongjo(type: .bold, size: 36)
        label.textColor = .inversePrimaryEmphasis
        label.numberOfLines = 2
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 50
        paragraphStyle.maximumLineHeight = 50
        
        label.attributedText = NSAttributedString(
            string: "안녕하세요.\n하루필사입니다.",
            attributes: [
                .kern: -0.03 * 36,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .regular, size: 15)
        label.textColor = UIColor(hexCode: "#FFFFFF", alpha: 0.6)
        label.numberOfLines = 2
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 23
        paragraphStyle.maximumLineHeight = 23
        
        label.attributedText = NSAttributedString(
            string: "문장을 따라 필사하며 이야기가 흐르는\n하루를 쌓아보세요.",
            attributes: [
                .kern: -0.03 * 36,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hexCode: "#222222")
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(titleLabel, autoLayout: [.topSafeArea(120), .leading(30)])
        view.addSubview(contentLabel, autoLayout: [.topNext(to: titleLabel, constant: 10), .leading(30)])
        
        let pilsaButton = NavigationButton(title: "필사하러 가기", image: .miText)
        let challengeButton = NavigationButton(title: "타이핑 대결하기", image: .miText2)
        let stackView = UIStackView()
        stackView.spacing = 5
        
        stackView.addArrangedSubview(pilsaButton)
        stackView.addArrangedSubview(challengeButton)
        
        view.addSubview(stackView, autoLayout: [.leading(25), .bottomSafeArea(25), .trailing(25)])
        pilsaButton.autoLayout([.widthEqual(to: challengeButton, constant: 1), .heightEqual(to: challengeButton, constant: 1), .aspectRatio(CGFloat(165/160))])
        
    }
}

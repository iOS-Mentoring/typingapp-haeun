//
//  ShareBottomSheetViewController.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/9/25.
//

import UIKit

final class ShareBottomSheetViewController: UIViewController {
    private let sheetTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .medium, size: 18)
        label.textColor = .primaryEmphasis
        label.text = "공유하기"
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.iconClose, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        setupSheetPresentation(bottomHeight: 210)
    }
    
    private func setupSheetPresentation(bottomHeight: CGFloat) {
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in bottomHeight - 40 })]
            sheet.preferredCornerRadius = 0
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(sheetTitleLabel, autoLayout: [.leading(20), .top(20)])
        view.addSubview(dismissButton, autoLayout: [.trailing(20), .top(18)])
        
        let buttonStackView = UIStackView()
        buttonStackView.addArrangedSubview(ShareButton(image: .snsIconKakao, title: "카카오톡"))
        buttonStackView.addArrangedSubview(ShareButton(image: .snsIconUrl, title: "URL 복사"))
        view.addSubview(buttonStackView, autoLayout: [.leading(20), .top(80), .trailing(20)])
    }
}

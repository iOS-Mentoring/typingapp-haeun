//
//  ViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/6/25.
//

import UIKit

class TypingViewController: BaseViewController {
    private let speedView = TypingSpeedView()
    private let typingInputAccessoryView = TypingInputAccessoryView()
    
    private let placeholderTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .gray300
        textView.backgroundColor = .gray200
        textView.font = .pretendard(type: .regular, size: 20)
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        
        textView.isEditable = false
        
        textView.text = "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
        
        return textView
    }()
    
    private let typingTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .gray300
        textView.backgroundColor = .clear
        textView.font = .pretendard(type: .regular, size: 20)
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        
        textView.becomeFirstResponder()
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setSpeedView()
        setTextView()
    }

    private func setNavigationBar() {
        title = "하루필사"
        
        let historyButton = UIBarButtonItem(
            image: .iconHistory,
            style: .plain,
            target: self,
            action: #selector(historyButtonTapped)
        )
        navigationItem.rightBarButtonItem = historyButton
    }
    
    @objc private func historyButtonTapped() {
        
    }
    
    private func setSpeedView() {
        view.addSubview(speedView, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .height(30)])
    }
    
    private func setTextView() {
        view.addSubview(placeholderTextView, autoLayout: [.topNext(to: speedView, constant: 0), .leading(0), .trailing(0), .bottom(0)])
        view.addSubview(typingTextView, autoLayout: [
            .topEqual(to: placeholderTextView, constant: 0),
            .leadingEqual(to: placeholderTextView, constant: 0),
            .trailingEqual(to: placeholderTextView, constant: 0),
            .bottomEqual(to: placeholderTextView, constant: 0)
        ])
        
        typingTextView.inputAccessoryView = typingInputAccessoryView
    }
}

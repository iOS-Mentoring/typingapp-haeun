//
//  ViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/6/25.
//

import UIKit
import Combine

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
    
    private let viewModel: TypingViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: TypingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setSpeedView()
        setTextView()
        setupBindings()
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
        let historyViewController = HistoryViewController()
        navigationController?.pushViewController(historyViewController, animated: true)
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
        
        placeholderTextView.text = viewModel.placeholderText
        
        typingTextView.inputAccessoryView = typingInputAccessoryView
        typingTextView.delegate = self
    }
    
    private func setupBindings() {
        viewModel.$elapsedTimeString
            .receive(on: DispatchQueue.main)
            .sink { [weak self] elapsedTimeString in
                guard let self else { return }
                self.speedView.updateTimeLabel(elapsedTimeString)
            }
            .store(in: &cancellables)
    }
}

extension TypingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.processInput(textView.text)
    }
}

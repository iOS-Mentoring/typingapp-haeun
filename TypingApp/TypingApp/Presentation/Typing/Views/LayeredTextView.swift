//
//  LayeredTextView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/24/25.
//

import UIKit
import Combine

protocol TextProcessing {
    func processInput(_ inputText: NSAttributedString)
    var attributedTextPublisher: AnyPublisher<NSAttributedString, Never> { get }
}

final class LayeredTextView: UIView {
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
    
    private var cancellables = Set<AnyCancellable>()
    private var processor: TextProcessing?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with processor: TextProcessing, placeholderText: String, inputAccessoryView: TypingInputAccessoryView) {
        self.processor = processor
        
        processor.attributedTextPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] attributedText in
                self?.typingTextView.attributedText = attributedText
            }
            .store(in: &cancellables)
        
        typingTextView.delegate = self
        typingTextView.inputAccessoryView = inputAccessoryView
        
        placeholderTextView.text = placeholderText
    }
    
    private func setupUI() {
        addSubview(placeholderTextView, autoLayout: [.top(0), .leading(0), .trailing(0), .bottom(0)])
        addSubview(typingTextView, autoLayout: [
            .topEqual(to: placeholderTextView, constant: 0),
            .leadingEqual(to: placeholderTextView, constant: 0),
            .trailingEqual(to: placeholderTextView, constant: 0),
            .bottomEqual(to: placeholderTextView, constant: 0)
        ])
    }
}

extension LayeredTextView {
    func setupKeyboardObservers() -> Set<AnyCancellable> {
        var cancellables = Set<AnyCancellable>()
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                self?.adjustInsets(height: height)
            }
            .store(in: &cancellables)
        
        return cancellables
    }
    
    private func adjustInsets(height: CGFloat) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        [typingTextView, placeholderTextView].forEach {
            $0.contentInset = contentInsets
            $0.scrollIndicatorInsets = contentInsets
        }
    }
    
    func scrollToVisible(textView: UITextView) {
        guard let selectedRange = textView.selectedTextRange else { return }
        let caretRect = textView.caretRect(for: selectedRange.end)
        let visibleRect = textView.bounds.inset(by: textView.contentInset)
        
        if !visibleRect.contains(convertToVisibleRect(caretRect, in: textView)) {
            textView.scrollRectToVisible(caretRect, animated: true)
            synchronizeScroll(from: textView)
        }
    }
    
    func synchronizeScroll(from source: UITextView) {
        placeholderTextView.contentOffset = source.contentOffset
    }
    
    // 텍스트뷰 내의 위치를 화면에 보이는 위치로 변환
    private func convertToVisibleRect(_ rect: CGRect, in textView: UITextView) -> CGRect {
        CGRect(
            origin: CGPoint(
                x: rect.origin.x - textView.contentOffset.x,
                y: rect.origin.y - textView.contentOffset.y
            ),
            size: rect.size
        )
    }
}

extension LayeredTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        processor?.processInput(textView.attributedText)
        scrollToVisible(textView: textView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == typingTextView {
            synchronizeScroll(from: typingTextView)
        }
    }
}

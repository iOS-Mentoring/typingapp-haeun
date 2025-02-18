//
//  TextViewScrollHandler.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/17/25.
//

import UIKit
import Combine

final class TextViewScrollHandler {
    private let editableTextView: UITextView
    private let backgroundTextView: UITextView
    
    init(editableTextView: UITextView, backgroundTextView: UITextView) {
        self.editableTextView = editableTextView
        self.backgroundTextView = backgroundTextView
    }
    
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
    
    func adjustInsets(height: CGFloat) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        [editableTextView, backgroundTextView].forEach {
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
        backgroundTextView.contentOffset = source.contentOffset
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

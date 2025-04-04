//
//  TypingViewModel.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/12/25.
//

import Foundation
import Combine
import UIKit

final class TypingViewModel {
    weak var coordinator: TypingCoordinator?
    
    @Published private(set) var placeholderText: String = ""
    @Published private(set) var wpm: Int = 0
    @Published private(set) var elapsedTimeString: String = "00:00:00"
    @Published private(set) var attributedText = NSAttributedString()
    @Published private(set) var isTypingEnded: Bool = false
    
    private var currentElapsedTime: TimeInterval?
    private var correctCharacterCount = 0
    private var cancellables = Set<AnyCancellable>()
    
    private let timerUseCase: TimerUseCase
    private let textProcessingUseCase: TextProcessingUseCase
    private let fetchTypingTextUseCase: FetchTypngTextUseCase
    
    init(timerUseCase: TimerUseCase, textProcessingUseCase: TextProcessingUseCase, fetchTypingTextUseCase: FetchTypngTextUseCase) {
        self.timerUseCase = timerUseCase
        self.textProcessingUseCase = textProcessingUseCase
        self.fetchTypingTextUseCase = fetchTypingTextUseCase
        loadPlaceholderText()
    }
    
    private func loadPlaceholderText() {
        fetchTypingTextUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] text in
                self?.placeholderText = text
            })
            .store(in: &cancellables)
    }
    
    private func startTyping() {
        timerUseCase.execute(.start)
            .sink { [weak self] state in
                guard let self = self else { return }
                self.elapsedTimeString = state.elapsedTimeString
                self.currentElapsedTime = state.elapsedTime
                self.updateWpm()
            }
            .store(in: &cancellables)
    }
    
    private func updateWpm() {
        guard let elapsedTime = currentElapsedTime, elapsedTime > 0 else { return }
        let wordsPerMinute = Double(correctCharacterCount) / elapsedTime * 60
        self.wpm = Int(wordsPerMinute)
    }
    
    private func createAttributedString(from text: String, incorrectRanges: [NSRange]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.primaryEmphasis,
            range: NSRange(location: 0, length: text.count)
        )
        
        for range in incorrectRanges {
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor.primaryRed,
                range: range
            )
        }
        
        return attributedString
    }
}

extension TypingViewModel: TextProcessing {
    func processInput(_ inputText: String) {
        if cancellables.isEmpty {
            startTyping()
        }
        
        let result = textProcessingUseCase.execute(inputText: inputText, placeholderText: placeholderText)
        attributedText = createAttributedString(from: inputText, incorrectRanges: result.incorrectRanges)
        correctCharacterCount = result.correctCharacterCount
        isTypingEnded = result.isTypingEnded
        
        if isTypingEnded {
            timerUseCase.execute(.stop)
                .sink { _ in }
                .store(in: &cancellables)
        }
        
        updateWpm()
    }
    
    var attributedTextPublisher: AnyPublisher<NSAttributedString, Never> {
        $attributedText.eraseToAnyPublisher()
    }
}

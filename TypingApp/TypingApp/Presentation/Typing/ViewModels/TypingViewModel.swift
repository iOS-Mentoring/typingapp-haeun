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
    
    @Published private(set) var wpm: Int = 0
    @Published private(set) var elapsedTimeString: String = "00:00:00"
    @Published private(set) var attributedText = NSAttributedString()
    @Published private(set) var isTypingEnded: Bool = false
    
    let placeholderText = "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
    private var currentElapsedTime: TimeInterval?
    private var correctCharacterCount = 0
    private var cancellables = Set<AnyCancellable>()
    
    private let timerUseCase: TimerUseCase
    private let textProcessingUseCase: TextProcessingUseCase
    
    init(timerUseCase: TimerUseCase, textProcessingUseCase: TextProcessingUseCase) {
        self.timerUseCase = timerUseCase
        self.textProcessingUseCase = textProcessingUseCase
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
    
    private func createAttributedString(from text: NSAttributedString, incorrectRanges: [NSRange]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: text)
        
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.primaryEmphasis,
            range: NSRange(location: 0, length: text.string.count)
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
    func processInput(_ inputText: NSAttributedString) {
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

//
//  TypingViewModel.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/12/25.
//

import Foundation
import Combine

final class TypingViewModel {
    weak var coordinator: TypingCoordinator?
    
    @Published private(set) var typingInfo: TypingInfo?
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
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] typingInfo in
                self?.typingInfo = typingInfo
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
}

extension TypingViewModel: TextProcessing {
    func processInput(_ inputText: NSAttributedString) {
        if currentElapsedTime == nil {
            startTyping()
        }
        
        let result = textProcessingUseCase.execute(inputText: inputText, placeholderText: typingInfo?.typing ?? "")
        attributedText = result.attributedText
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

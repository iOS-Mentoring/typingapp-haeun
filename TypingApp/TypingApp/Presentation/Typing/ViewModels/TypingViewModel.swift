//
//  TypingViewModel.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/12/25.
//

import Foundation
import Combine

struct TypingViewModelInput: ViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let textViewDidChange: AnyPublisher<NSAttributedString, Never>
}

struct TypingViewModelOutput: ViewModelOutput {
    let typingInfo: AnyPublisher<TypingInfo, Never>
    let wpm: AnyPublisher<Int, Never>
    let elapsedTimeString: AnyPublisher<String, Never>
    let attributedText: AnyPublisher<NSAttributedString, Never>
    let isTypingEnded: AnyPublisher<Bool, Never>
}

final class TypingViewModel: ViewModelProtocol {
    weak var coordinator: TypingCoordinator?
    private var cancellables = Set<AnyCancellable>()
    private let timerUseCase: TimerUseCase
    private let textProcessingUseCase: TextProcessingUseCase
    private let fetchTypingTextUseCase: FetchTypngTextUseCase
    
    typealias Input = TypingViewModelInput
    typealias Output = TypingViewModelOutput
    
    private var currentElapsedTime: TimeInterval?
    private var correctCharacterCount = 0
    
    private var typingInfoSubject = CurrentValueSubject<TypingInfo, Never>(TypingInfo(title: "", typing: "", author: "", url: ""))
    private var wpmSubject = CurrentValueSubject<Int, Never>(0)
    private var elapsedTimeStringSubject = CurrentValueSubject<String, Never>("00:00:00")
    private var attributedTextSubject = CurrentValueSubject<NSAttributedString, Never>(NSAttributedString())
    private var isTypingEndedSubject = CurrentValueSubject<Bool, Never>(false)
    
    init(timerUseCase: TimerUseCase, textProcessingUseCase: TextProcessingUseCase, fetchTypingTextUseCase: FetchTypngTextUseCase) {
        self.timerUseCase = timerUseCase
        self.textProcessingUseCase = textProcessingUseCase
        self.fetchTypingTextUseCase = fetchTypingTextUseCase
    }
    
    func transform(input: TypingViewModelInput) -> TypingViewModelOutput {
        input.viewDidLoad
            .sink { [weak self] in
                self?.fetchTypingInfo()
            }
            .store(in: &cancellables)
        
        input.textViewDidChange
            .sink { [weak self] attributedString in
                self?.processInput(attributedString)
            }
            .store(in: &cancellables)
        
        return Output(
            typingInfo: typingInfoSubject.eraseToAnyPublisher(),
            wpm: wpmSubject.eraseToAnyPublisher(),
            elapsedTimeString: elapsedTimeStringSubject.eraseToAnyPublisher(),
            attributedText: attributedTextSubject.eraseToAnyPublisher(),
            isTypingEnded: isTypingEndedSubject.eraseToAnyPublisher()
        )
    }
    
    private func fetchTypingInfo() {
        Task {
            do {
                let typingInfo = try await fetchTypingTextUseCase.execute()
                typingInfoSubject.send(typingInfo)
            } catch {
                
            }
        }
    }
    
    private func startTyping() {
        timerUseCase.execute(.start)
            .sink { [weak self] state in
                guard let self = self else { return }
                elapsedTimeStringSubject.send(state.elapsedTimeString)
                self.currentElapsedTime = state.elapsedTime
                self.updateWpm()
            }
            .store(in: &cancellables)
    }
    
    private func updateWpm() {
        guard let elapsedTime = currentElapsedTime, elapsedTime > 0 else { return }
        let wordsPerMinute = Double(correctCharacterCount) / elapsedTime * 60
        //self.wpm = Int(wordsPerMinute)
        wpmSubject.send(Int(wordsPerMinute))
    }
    
}

extension TypingViewModel {
    func processInput(_ inputText: NSAttributedString) {
        if currentElapsedTime == nil {
            startTyping()
        }
        
        let result = textProcessingUseCase.execute(inputText: inputText, placeholderText: typingInfoSubject.value.typing)
        attributedTextSubject.send(result.attributedText)
        correctCharacterCount = result.correctCharacterCount
        isTypingEndedSubject.send(result.isTypingEnded)
        
        if isTypingEndedSubject.value {
            timerUseCase.execute(.stop)
                .sink { _ in }
                .store(in: &cancellables)
        }
        
        updateWpm()
    }
    
    /*var attributedTextPublisher: AnyPublisher<NSAttributedString, Never> {
        $attributedText.eraseToAnyPublisher()
    }*/
}

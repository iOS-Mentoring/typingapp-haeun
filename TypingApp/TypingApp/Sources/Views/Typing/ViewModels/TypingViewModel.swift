//
//  TypingViewModel.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/12/25.
//

import Foundation
import Combine

class TypingViewModel {
    @Published private(set) var wpm: Int = 0
    @Published private(set) var elapsedTimeString: String = "00:00:00"
    
    let placeholderText: String
    private var startTime: Date?
    private var correctCharacterCount = 0
    private var timer: AnyCancellable?
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
    }
    
    func processInput(_ inputText: String) {
        if startTime == nil { startTimer() }
        
        // TODO: inputText 와 placeholderText 비교하여 올바른 character 입력했는지 확인
    }
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self,
                let startTime = self.startTime else { return }
                self.updateWpm(from: startTime)
            }
    }
    
    private func updateWpm(from startTime: Date) {
        let timeElapsed = Date().timeIntervalSince(startTime)
        
        let hours = Int(timeElapsed) / 3600
        let minutes = Int(timeElapsed) / 60 % 60
        let seconds = Int(timeElapsed) % 60
        
        self.elapsedTimeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
        let wordsPerMinute = Double(correctCharacterCount) / timeElapsed * 60
        self.wpm = Int(wordsPerMinute)
    }
    
}

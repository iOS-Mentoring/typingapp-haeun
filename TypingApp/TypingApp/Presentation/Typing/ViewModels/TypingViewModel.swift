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
    private var startTime: Date?
    private var correctCharacterCount = 0
    private var timer: AnyCancellable?
    
    func processInput(_ inputText: NSAttributedString) {
        if startTime == nil {
            startTimer()
        }
        
        if inputText.string == placeholderText {
            attributedText = createAttributedString(from: inputText, incorrectRanges: [])
            timer?.cancel()
            isTypingEnded = true
            return
        }
        
        let inputWords = inputText.string.components(separatedBy: " ")
        let targetWords = placeholderText.components(separatedBy: " ")
        correctCharacterCount = 0
        var incorrectRanges: [NSRange] = []
        
        var currentLocation = 0
        for (index, inputWord) in inputWords.enumerated() {
            if index >= targetWords.count {
                let range = NSRange(location: currentLocation, length: inputWord.count)
                incorrectRanges.append(range)
                currentLocation += inputWord.count
                if index < inputWords.count - 1 {
                    currentLocation += 1
                }
                continue
            }
            
            let targetWord = targetWords[index]
            
            // 자모음 단위로 분해하여 비교
            let decomposedInput = inputWord.decompose()
            let decomposedTarget = targetWord.decompose()
            
            // 분해된 자모음 단위로 정확한 문자 수 카운트
            let correctJamo = zip(decomposedInput, decomposedTarget)
                .filter { $0.0 == $0.1 }
                .count
            
            // 단어가 완전히 일치하지 않으면 해당 범위를 틀린 것으로 표시
            if inputWord != targetWord {
                let range = NSRange(location: currentLocation, length: inputWord.count)
                incorrectRanges.append(range)
            }
            
            correctCharacterCount += correctJamo
            
            currentLocation += inputWord.count
            if index < inputWords.count - 1 {
                currentLocation += 1
            }
        }
        
        attributedText = createAttributedString(from: inputText, incorrectRanges: incorrectRanges)
        updateWpm(from: startTime!)
        
    }
    
    private func createAttributedString(from text: NSAttributedString, incorrectRanges: [NSRange]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: text)
        
        // 기본 색상으로 설정
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.primaryEmphasis,
            range: NSRange(location: 0, length: text.string.count)
        )
        
        // 틀린 부분 빨간색으로 설정
        for range in incorrectRanges {
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor.primaryRed,
                range: range
            )
        }
        
        return attributedString
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

//
//  TextProcessingUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/3/25.
//

import Foundation

protocol TextProcessingUseCaseProtocol {
    func execute(inputText: String, placeholderText: String) -> (incorrectRanges: [NSRange], correctCharacterCount: Int, isTypingEnded: Bool)
}

final class TextProcessingUseCase: TextProcessingUseCaseProtocol {
    func execute(inputText: String, placeholderText: String) -> (incorrectRanges: [NSRange], correctCharacterCount: Int, isTypingEnded: Bool) {
        let inputWords = inputText.components(separatedBy: " ")
        let targetWords = placeholderText.components(separatedBy: " ")
        var incorrectRanges: [NSRange] = []
        var correctCharacterCount = 0
        var currentLocation = 0
        
        for (index, inputWord) in inputWords.enumerated() {
            if index >= targetWords.count || inputWord != targetWords[index] {
                let range = NSRange(location: currentLocation, length: inputWord.count)
                incorrectRanges.append(range)
            }
            correctCharacterCount += inputWord.count
            currentLocation += inputWord.count + 1
        }
        
        let isTypingEnded = inputText == placeholderText
        return (incorrectRanges, correctCharacterCount, isTypingEnded)
    }
}

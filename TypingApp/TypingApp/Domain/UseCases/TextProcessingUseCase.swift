//
//  TextProcessingUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/3/25.
//

import Foundation

protocol TextProcessingUseCase {
    func execute(inputText: NSAttributedString, placeholderText: String) -> (incorrectRanges: [NSRange], correctCharacterCount: Int, isTypingEnded: Bool)
}

final class TextProcessingUseCaseImpl: TextProcessingUseCase {
    func execute(inputText: NSAttributedString, placeholderText: String) -> (incorrectRanges: [NSRange], correctCharacterCount: Int, isTypingEnded: Bool) {
        let inputWords = inputText.string.components(separatedBy: " ")
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
        
        let isTypingEnded = inputText.string == placeholderText
        return (incorrectRanges, correctCharacterCount, isTypingEnded)
    }
}

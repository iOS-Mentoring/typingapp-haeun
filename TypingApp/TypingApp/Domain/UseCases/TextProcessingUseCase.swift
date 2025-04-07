//
//  TextProcessingUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/3/25.
//

import Foundation
import UIKit

protocol TextProcessingUseCaseProtocol {
    func execute(inputText: NSAttributedString, placeholderText: String) -> (attributedText: NSAttributedString, correctCharacterCount: Int, isTypingEnded: Bool)
}

final class TextProcessingUseCase: TextProcessingUseCaseProtocol {
    func execute(inputText: NSAttributedString, placeholderText: String) -> (attributedText: NSAttributedString, correctCharacterCount: Int, isTypingEnded: Bool) {
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
        let attributedText = createAttributedString(from: inputText, incorrectRanges: incorrectRanges)
        let isTypingEnded = inputText.string == placeholderText
        return (attributedText, correctCharacterCount, isTypingEnded)
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

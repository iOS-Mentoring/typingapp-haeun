//
//  TextProcessingUseCaseTests.swift
//  TypingApp
//
//  Created by Haeun Kwon on 6/23/25.
//

import Testing
import Foundation
import UIKit
@testable import TypingApp

struct TextProcessingUseCaseTests {
    
    private let usecase = TextProcessingUseCase()
    
    @Test
    func execute_correctInput() async throws {
        let inputText = NSAttributedString(string: "Hello World")
        let placeholderText = "Hello World"
        
        let result = usecase.execute(inputText: inputText, placeholderText: placeholderText)
        
        #expect(result.attributedText.string == "Hello World")
        #expect(result.correctCharacterCount == 10)
        #expect(result.isTypingEnded == true)
        let attributes = result.attributedText.attributes(at: 0, effectiveRange: nil)
        #expect(attributes[.foregroundColor] as? UIColor == UIColor.primaryEmphasis)
    }
    
    @Test
    func execute_incorrectInput() async throws {
        let inputText = NSAttributedString(string: "hi world")
        let placeholderText = "hello world"
        
        let result = usecase.execute(inputText: inputText, placeholderText: placeholderText)
        
        #expect(result.attributedText.string == "hi world")
        #expect(result.correctCharacterCount == 7)
        #expect(result.isTypingEnded == false)
        
        let firstWordAttributes = result.attributedText.attributes(at: 0, effectiveRange: nil)
        #expect(firstWordAttributes[.foregroundColor] as? UIColor == UIColor.primaryRed)
        
        let secondWordAttributes = result.attributedText.attributes(at: 3, effectiveRange: nil)
        #expect(secondWordAttributes[.foregroundColor] as? UIColor == UIColor.primaryEmphasis)
    }
}

//
//  ViewModelProtocol.swift
//  TypingApp
//
//  Created by Haeun Kwon on 5/21/25.
//

import Foundation

protocol ViewModelInput {}
protocol ViewModelOutput {}

@MainActor
protocol ViewModelProtocol {
    associatedtype Input: ViewModelInput
    associatedtype Output: ViewModelOutput
    
    func transform(input: Input) -> Output
}

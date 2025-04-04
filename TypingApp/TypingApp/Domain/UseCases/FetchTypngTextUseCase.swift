//
//  FetchTypngTextUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/4/25.
//

import Combine

protocol FetchTypngTextUseCase {
    func execute() -> AnyPublisher<String, Error>
}

final class FetchTypngTextUseCaseImpl: FetchTypngTextUseCase {
    private let repository: TypingTextRepository
    
    init(repository: TypingTextRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<String, Error> {
        return repository.fetchTypingText()
    }
}

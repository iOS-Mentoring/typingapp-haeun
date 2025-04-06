//
//  FetchTypngTextUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/4/25.
//

import Combine

protocol FetchTypngTextUseCase {
    func execute() -> AnyPublisher<TypingInfo, Error>
}

final class FetchTypngTextUseCaseImpl: FetchTypngTextUseCase {
    private let repository: TypingRepositoryProtocol
    
    init(repository: TypingRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<TypingInfo, Error> {
        return repository.fetchTypingInfoPublisher()
    }
}

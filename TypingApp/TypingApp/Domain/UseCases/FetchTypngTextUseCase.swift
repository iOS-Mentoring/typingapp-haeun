//
//  FetchTypngTextUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/4/25.
//

import Combine

protocol FetchTypngTextUseCaseProtocol {
    func execute() -> AnyPublisher<TypingInfo, Error>
}

final class FetchTypngTextUseCase: FetchTypngTextUseCaseProtocol {
    private let repository: TypingRepositoryProtocol
    
    init(repository: TypingRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<TypingInfo, Error> {
        return repository.fetchTypingInfoPublisher()
    }
}

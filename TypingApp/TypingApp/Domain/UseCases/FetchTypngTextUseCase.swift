//
//  FetchTypngTextUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/4/25.
//

import Combine

protocol FetchTypngTextUseCaseProtocol: Sendable {
    func execute() async throws -> TypingInfo
}

final class FetchTypngTextUseCase: FetchTypngTextUseCaseProtocol {
    private let repository: TypingRepositoryProtocol
    
    init(repository: TypingRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> TypingInfo {
        return try await repository.fetchTypingInfo()
    }
}

//
//  FetchRecordUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 5/26/25.
//

import Combine
import Foundation

protocol FetchRecordUseCaseProtocol: Sendable {
    func execute(for date: Date) async throws -> Record
}

final class FetchRecordUseCase: FetchRecordUseCaseProtocol {
    private let repository: RecordRepository
    
    init(repository: RecordRepository) {
        self.repository = repository
    }
    
    func execute(for date: Date) async throws -> Record {
        return try await repository.fetchRecord(for: date)
    }
}

//
//  FetchRecordUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 5/26/25.
//

import Foundation

protocol FetchRecordUseCaseProtocol: Sendable {
    func execute(for date: Date) async throws -> TypingRecord
}

final class FetchRecordUseCase: FetchRecordUseCaseProtocol {
    private let repository: RecordRepository
    
    init(repository: RecordRepository) {
        self.repository = repository
    }
    
    func execute(for date: Date) async throws -> TypingRecord {
        return try await repository.fetchRecord(for: date)
    }
}

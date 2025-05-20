//
//  CalendarUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/29/25.
//

import Foundation
import Combine

protocol FetchCalendarDataUseCaseProtocol: Sendable {
    func execute() async throws -> [Date]
}

final class FetchCalendarDataUseCase: FetchCalendarDataUseCaseProtocol {
    private let repository: CalendarRepositoryProtocol
    private let calendar = Calendar.current
    
    init(repository: CalendarRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Date] {
        return try await repository.fetchCalendarDate()
    }
}

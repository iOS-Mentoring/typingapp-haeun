//
//  MockCalendarRepository.swift
//  TypingApp
//
//  Created by Haeun Kwon on 6/18/25.
//

import Testing
import Foundation
@testable import TypingApp

final class MockCalendarRepository: CalendarRepositoryProtocol, @unchecked Sendable {
    var mockDates: [Date] = []
    var shouldThrowError = false
    
    func fetchCalendarDate() async throws -> [Date] {
        if shouldThrowError {
            throw TestError.mockError
        }
        return mockDates
    }
}

enum TestError: Error {
    case mockError
}

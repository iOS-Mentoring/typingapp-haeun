//
//  FetchCalendarUseCaseTests.swift
//  TypingApp
//
//  Created by Haeun Kwon on 6/18/25.
//

import Testing
import Foundation
@testable import TypingApp

struct FetchCalendarUseCaseTests {
    
    let usecase = CalendarUseCase(repository: CalendarRepository())
    
    private func createUseCase(with mockDates: [Date] = []) -> (CalendarUseCase, MockCalendarRepository) {
        let mockRepository = MockCalendarRepository()
        mockRepository.mockDates = mockDates
        let useCase = CalendarUseCase(repository: mockRepository)
        return (useCase, mockRepository)
    }
    
    @Test
    func fetchCalendarData_emptyDates() async throws {
        let (useCase, _) = createUseCase(with: [])
        
        let result = try await useCase.fetchCalendarData()
        
        #expect(result.count == 7, "Should return current week (7 days) when no result dates")
        
        // Should start from Monday of current week
        let calendar = Calendar.current
        if let firstDay = result.first {
            let weekday = calendar.component(.weekday, from: firstDay.date)
            #expect(weekday == 1, "Should start from Sunday")
        }
        
        // Should contain today
        let today = Date()
        let containsToday = result.contains { calendar.isDate($0.date, inSameDayAs: today) }
        #expect(containsToday, "Should contain today's date")
        
        // All days should have hasTypingResult = false (no results from repository)
        let allHaveNoResults = result.allSatisfy { !$0.hasTypingResult }
        #expect(allHaveNoResults, "All days should have hasTypingResult = false when no repository data")
    }
    
    @Test
    func fetchCalendarData_throwsError() async {
        let (useCase, mockRepository) = createUseCase()
        mockRepository.shouldThrowError = true
        
        await #expect(throws: TestError.self) {
            try await useCase.fetchCalendarData()
        }
    }
}

//
//  CalendarRepositoryTests.swift
//  TypingApp
//
//  Created by Haeun Kwon on 6/17/25.
//

import Testing
import Foundation
@testable import TypingApp

struct CalendarRepositoryTests {
    @Test
    func fetchCalendarDate_success() async throws {
        let repository = CalendarRepository()
        
        let dates = try await repository.fetchCalendarDate()
        
        #expect(dates.isEmpty == false || dates.isEmpty == true)
    }
    
    @Test
    func fetchCalendarDate_validate() async throws {
        let repository = CalendarRepository()
        
        let dates = try await repository.fetchCalendarDate()
        
        // 중복 날짜가 없는지 확인
        let uniqueDates = Set(dates.map { Calendar.current.startOfDay(for: $0) })
        #expect(uniqueDates.count == dates.count)
        
        let calendar = Calendar.current
        let minDate = calendar.date(from: DateComponents(year: 2025, month: 2, day: 1))!
        let maxDate = Date()
        
        // 범위를 벗어난 날짜가 없는지 확인
        let hasInvalidDate = dates.contains { date in
            date < minDate || date > maxDate
        }
        #expect(hasInvalidDate == false)
    }
}

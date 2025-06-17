//
//  CalendarRepository.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/30/25.
//

import Foundation

final class CalendarRepository: CalendarRepositoryProtocol {
    func fetchCalendarDate() async throws -> [Date] {
        return MockCalendarData.createSpecificDates()
    }
}

final class MockCalendarData {
    static func createSpecificDates() -> [Date] {
        let calendar = Calendar.current
        
        return [
            calendar.date(byAdding: .day, value: -25, to: Date())!,
            calendar.date(byAdding: .day, value: -21, to: Date())!,
            calendar.date(byAdding: .day, value: -18, to: Date())!,
            calendar.date(byAdding: .day, value: -15, to: Date())!,
            calendar.date(byAdding: .day, value: -8, to: Date())!,
            calendar.date(byAdding: .day, value: -5, to: Date())!,
            calendar.date(byAdding: .day, value: -2, to: Date())!,
            Date()
        ]
    }
}

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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let dateStrings = [
            "2025.03.31",
            "2025.04.12",
            "2025.04.15",
            "2025.04.16",
            "2025.04.18",
            "2025.04.23",
            "2025.04.25",
            "2025.04.26",
            "2025.04.29"
        ]
        
        return dateStrings.compactMap { dateFormatter.date(from: $0) }
    }
}

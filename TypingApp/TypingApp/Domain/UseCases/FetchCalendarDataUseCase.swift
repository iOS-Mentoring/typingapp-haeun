//
//  CalendarUseCase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/29/25.
//

import Foundation
import Combine

protocol CalendarUseCaseProtocol: Sendable {
    func fetchCalendarData() async throws -> [CalendarDay]
}

final class CalendarUseCase: CalendarUseCaseProtocol {
    private let repository: CalendarRepositoryProtocol
    private let calendar = Calendar.current
    
    init(repository: CalendarRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchCalendarData() async throws -> [CalendarDay] {
        let resultDates = try await repository.fetchCalendarDate()
        
        let sortedResultDates = resultDates.sorted()
        let earliestDate = sortedResultDates.first!
        let today = Date()
        
        let resultDateSet = Set(sortedResultDates.map { calendar.startOfDay(for: $0) })
        let calendarDays = generateCalendarDays(from: earliestDate, to: today, resultDateSet: resultDateSet)
        return calendarDays
    }
    
    private func generateCalendarDays(from startDate: Date, to endDate: Date, resultDateSet: Set<Date>) -> [CalendarDay] {
        guard let weekStart = getWeekStart(for: startDate),
              let weekEnd = getWeekEnd(for: endDate) else {
            return []
        }
        
        var calendarDays: [CalendarDay] = []
        var currentDate = weekStart
        
        let validStartDate = calendar.startOfDay(for: startDate)
        let validEndDate = calendar.startOfDay(for: endDate)
        
        while currentDate <= weekEnd {
            let dayStartDate = calendar.startOfDay(for: currentDate)
            let hasResult = resultDateSet.contains(dayStartDate)
            let isInValidRange = dayStartDate >= validStartDate && dayStartDate <= validEndDate
            //let isToday = calendar.isDate(currentDate, inSameDayAs: Date())
            
            let calendarDay = CalendarDay(
                date: currentDate,
                hasTypingResult: hasResult,
                isInValidRange: isInValidRange
            )
            
            calendarDays.append(calendarDay)
            
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                break
            }
            currentDate = nextDate
        }
        
        return calendarDays
    }
    
    private func getWeekStart(for date: Date) -> Date? {
        let weekday = calendar.component(.weekday, from: date)
        let daysFromMonday = (weekday + 6) % 7
        return calendar.date(byAdding: .day, value: -daysFromMonday, to: date)
    }
    
    private func getWeekEnd(for date: Date) -> Date? {
        guard let weekStart = getWeekStart(for: date) else { return nil }
        return calendar.date(byAdding: .day, value: 6, to: weekStart)
    }
}

//
//  CalendarViewModel.swift
//  TypingApp
//
//  Created by 권하은 on 2/25/25.
//

import Foundation
import Combine

final class CalendarViewModel {
    private let calendar = Calendar.current
    private var allDays: [DayModel] = []
    private var selectedDateIndex: Int? {
        didSet {
            if let index = selectedDateIndex, index < allDays.count {
                selectedDaySubject.send(allDays[index])
            } else {
                selectedDaySubject.send(nil)
            }
        }
    }
    
    private let daysSubject = CurrentValueSubject<[DayModel], Never>([])
    private let selectedDaySubject = CurrentValueSubject<DayModel?, Never>(nil)
    
    var daysPublisher: AnyPublisher<[DayModel], Never> {
        return daysSubject.eraseToAnyPublisher()
    }
    
    var selectedDayPublisher: AnyPublisher<DayModel?, Never> {
        return selectedDaySubject.eraseToAnyPublisher()
    }
    
    var days: [DayModel] {
        return daysSubject.value
    }
    
    init() {
        setupCalendarData()
        selectToday()
    }
    
    func weekdaySymbols() -> [String] {
        return calendar.shortWeekdaySymbols
    }
    
    func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    func selectDay(at index: Int) {
        guard index >= 0, index < allDays.count else { return }
        selectedDateIndex = index
    }
    
    func selectedIndex() -> Int? {
        return selectedDateIndex
    }
    
    func todayWeekIndex() -> Int? {
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        
        guard let todayIndex = allDays.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: today) }) else {
            return nil
        }
        
        let sundayIndex = todayIndex - (weekday - 1)
        
        if sundayIndex >= 0 && sundayIndex < allDays.count {
            return sundayIndex
        }
        
        return nil
    }
    
    // 달력 데이터 초기 설정
    private func setupCalendarData() {
        let today = Date()
        
        let firstDayComponents = calendar.dateComponents([.year, .month], from: today)
        guard let firstDayOfMonth = calendar.date(from: firstDayComponents) else {
            return
        }
        
        // 시작일 (이번 달 첫 주의 일요일)
        let weekdayOfFirstDay = calendar.component(.weekday, from: firstDayOfMonth)
        guard let startDate = calendar.date(byAdding: .day, value: -(weekdayOfFirstDay - 1), to: firstDayOfMonth) else {
            return
        }
        
        // 10주치 날짜 데이터 생성
        var days: [DayModel] = []
        var currentDate = startDate
        
        for _ in 0..<70 {
            days.append(DayModel(
                date: currentDate,
                dateString: formattedDate(for: currentDate),
                hasTypingResult: hasTypingResult(for: currentDate)
            ))
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        allDays = days
        daysSubject.send(days)
    }
    
    private func selectToday() {
        let today = Date()
        if let todayIndex = allDays.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: today) }) {
            selectedDateIndex = todayIndex
        }
    }
    
    private func hasTypingResult(for date: Date) -> Bool {
        let day = calendar.component(.day, from: date)
        return day % 3 == 0
    }
}

//
//  CalendarViewModel.swift
//  TypingApp
//
//  Created by 권하은 on 2/25/25.
//

import Foundation

final class CalendarViewModel {
    func weekdaySymbols() -> [String] {
        return Calendar.current.shortWeekdaySymbols
    }
}

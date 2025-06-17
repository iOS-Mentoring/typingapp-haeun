//
//  CalendarRepositoryProtocol.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/30/25.
//

import Foundation

protocol CalendarRepositoryProtocol: Sendable {
    func fetchCalendarDate() async throws -> [Date]
}

//
//  HistoryViewModel.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/30/25.
//

import Foundation
import Combine

@MainActor
final class HistoryViewModel {
    @Published private(set) var dateInfo: [Date]?
    
    private let fetchCalendarDataUseCase: FetchCalendarDataUseCaseProtocol
    
    init(fetchCalendarDataUseCase: FetchCalendarDataUseCaseProtocol) {
        self.fetchCalendarDataUseCase = fetchCalendarDataUseCase
    }
    
    nonisolated func loadCalendarData() async throws -> [Date] {
        return try await fetchCalendarDataUseCase.execute()
    }
    
    func loadCalendarData() {
        Task {
            do {
                let data = try await loadCalendarData()
                print(data)
            } catch {
                
            }
        }
        
    }
}

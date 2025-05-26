//
//  HistoryViewModel.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/30/25.
//

import Foundation
import Combine

struct HistoryViewModelInput: ViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let dayIndexSelected: AnyPublisher<IndexPath, Never>
}

struct HistoryViewModelOutput: ViewModelOutput {
    let dayInfo: AnyPublisher<[CalendarDay], Never>
    let selectedDayIndex: AnyPublisher<IndexPath, Never>
}

final class HistoryViewModel: ViewModelProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    private let calendarUseCase: CalendarUseCaseProtocol
    
    typealias Input = HistoryViewModelInput
    typealias Output = HistoryViewModelOutput
    
    private var dayInfoSubject = PassthroughSubject<[CalendarDay], Never>()
    private var selectedIndexSubject = PassthroughSubject<IndexPath, Never>()
    
    init(calendarUseCase: CalendarUseCaseProtocol) {
        self.calendarUseCase = calendarUseCase
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad
            .sink { [weak self] in
                self?.fetchCalendarData()
            }
            .store(in: &cancellables)
        
        input.dayIndexSelected
            .sink { [weak self] selectedDayIndex in
                self?.selectedIndexSubject.send(selectedDayIndex)
            }
            .store(in: &cancellables)
        
        return Output(
            dayInfo: dayInfoSubject.eraseToAnyPublisher(),
            selectedDayIndex: selectedIndexSubject.eraseToAnyPublisher()
        )
    }
    
    private func fetchCalendarData() {
        Task {
            do {
                let dayInfo = try await calendarUseCase.fetchCalendarData()
                dayInfoSubject.send(dayInfo)
            } catch {
                
            }
        }
    }
}

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
    let recordInfo: AnyPublisher<RecordDisplayState, Never>
}

enum RecordDisplayState {
    case record(Record)
    case empty
}

final class HistoryViewModel: ViewModelProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    private let calendarUseCase: CalendarUseCaseProtocol
    private let fetchRecordUseCase: FetchRecordUseCaseProtocol
    
    typealias Input = HistoryViewModelInput
    typealias Output = HistoryViewModelOutput
    
    private var dayInfoSubject = CurrentValueSubject<[CalendarDay], Never>([])
    private var selectedIndexSubject = PassthroughSubject<IndexPath, Never>()
    private var recordInfoSubject = PassthroughSubject<RecordDisplayState, Never>()
    
    init(calendarUseCase: CalendarUseCaseProtocol, fetchRecordUseCase: FetchRecordUseCaseProtocol) {
        self.calendarUseCase = calendarUseCase
        self.fetchRecordUseCase = fetchRecordUseCase
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
                self?.handleDaySelection(at: selectedDayIndex)
            }
            .store(in: &cancellables)
        
        return Output(
            dayInfo: dayInfoSubject.eraseToAnyPublisher(),
            selectedDayIndex: selectedIndexSubject.eraseToAnyPublisher(),
            recordInfo: recordInfoSubject.eraseToAnyPublisher()
        )
    }
    
    private func fetchCalendarData() {
        Task {
            do {
                let dayInfo = try await calendarUseCase.fetchCalendarData()
                dayInfoSubject.send(dayInfo)
                self.selectToday()
            } catch {
                
            }
        }
    }
    
    private func handleDaySelection(at indexPath: IndexPath) {
        let currentDayInfo = dayInfoSubject.value
        
        let selectedDay = currentDayInfo[indexPath.row]
        if selectedDay.hasTypingResult {
            fetchRecordData(for: selectedDay.date)
        } else {
            recordInfoSubject.send(.empty)
        }
    }
    
    private func fetchRecordData(for date: Date) {
        Task {
            do {
                let recordInfo = try await fetchRecordUseCase.execute(for: date)
                recordInfoSubject.send(.record(recordInfo))
            } catch {
                
            }
        }
    }
    
    private func selectToday() {
        let currentDayInfo = dayInfoSubject.value
        
        let today = Calendar.current.startOfDay(for: Date())
        if let todayIndex = currentDayInfo.firstIndex(where: { day in
            Calendar.current.isDate(day.date, inSameDayAs: today)
        }) {
            let indexPath = IndexPath(row: todayIndex, section: 0)
            selectedIndexSubject.send(indexPath)
            handleDaySelection(at: indexPath)
        }
    }
}

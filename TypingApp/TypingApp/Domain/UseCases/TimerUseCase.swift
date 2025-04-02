//
//  TimerUsecase.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/1/25.
//

import Foundation
import Combine

enum TimerCommand {
    case start
    case stop
}

struct TimerState {
    let elapsedTimeString: String
    let elapsedTime: TimeInterval
}

protocol TimerUseCase {
    func execute(_ command: TimerCommand) -> AnyPublisher<TimerState, Never>
}

final class TimerUseCaseImpl: TimerUseCase {
    private var timer: AnyCancellable?
    private var startTime: Date?
    private let stateSubject = CurrentValueSubject<TimerState, Never>(
        TimerState(elapsedTimeString: "00:00:00", elapsedTime: 0)
    )
    
    func execute(_ command: TimerCommand) -> AnyPublisher<TimerState, Never> {
        switch command {
        case .start:
            startTimer()
        case .stop:
            stopTimer()
        }
        return stateSubject
            .eraseToAnyPublisher()
    }
    
    private func startTimer() {
        guard timer == nil else { return }
        
        startTime = Date()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self,
                      let startTime = self.startTime else { return }
                let elapsed = Date().timeIntervalSince(startTime)
                let timeString = self.formatTimeInterval(elapsed)
                
                self.stateSubject.send(
                    TimerState(elapsedTimeString: timeString, elapsedTime: elapsed)
                    )
            }
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func formatTimeInterval(_ timeElapsed: TimeInterval) -> String {
        let hours = Int(timeElapsed) / 3600
        let minutes = Int(timeElapsed) / 60 % 60
        let seconds = Int(timeElapsed) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

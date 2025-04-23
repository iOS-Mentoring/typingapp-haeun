//
//  HistoryViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/11/25.
//

import UIKit
import Combine

final class HistoryViewController: UIViewController {
    private let calendarViewModel = CalendarViewModel()
    private lazy var calendarView = CalendarView(viewModel: calendarViewModel)
    private let historyContentView = HistoryContentView()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        title = "하루 보관함"
        view.addSubview(calendarView, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .height(95)])
        view.addSubview(historyContentView, autoLayout: [.topNext(to: calendarView, constant: 0), .leading(20), .trailing(20), .bottom(0)])
    }
    
    private func setupBindings() {
        calendarViewModel.selectedDayPublisher
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] day in
                self?.historyContentView.configure(with: day)
            }
            .store(in: &cancellables)
    }
}

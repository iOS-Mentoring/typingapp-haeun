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
    
    private let todayButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = .pretendard(type: .semiBold, size: 12)
        titleContainer.foregroundColor = .primaryEmphasis
        config.attributedTitle = AttributedString("오늘", attributes: titleContainer)
        config.image = .iconArrow
        config.imagePlacement = .trailing
        config.imagePadding = 6
        config.cornerStyle = .capsule
        config.background.backgroundColor = .white
        
        button.layer.shadowColor = .primaryEmphasis
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.12
        
        button.configuration = config
        button.frame.size = CGSize(width: 54, height: 32)
        return button
    }()
    
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
        view.addSubview(todayButton, autoLayout: [.bottomSafeArea(30), .centerX(0)])
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

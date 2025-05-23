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
    private lazy var calendarView = CalendarView()
    private let viewModel: HistoryViewModel
    
    private let viewDidLoadTrigger = PassthroughSubject<Void, Never>()
    
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
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        title = "하루 보관함"
        view.addSubview(calendarView, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .height(95)])
        view.addSubview(historyContentView, autoLayout: [.topNext(to: calendarView, constant: 0), .leading(20), .trailing(20), .bottom(0)])
        view.addSubview(todayButton, autoLayout: [.bottomSafeArea(30), .centerX(0)])
    }
    
    private func bind() {
        let input = HistoryViewModelInput(
            viewDidLoad: viewDidLoadTrigger.eraseToAnyPublisher(),
            daySelected: calendarView.daySelected.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input: input)
        
        viewDidLoadTrigger.send()
        
        output.dayInfo
            .sink { [weak self] dayInfo in
                guard let self else { return }
                calendarView.applySnapshot(items: dayInfo)
            }
            .store(in: &cancellables)
        
        let todayAction = UIAction { _ in
            //calendarViewModel.
        }
        todayButton.addAction(todayAction, for: .touchUpInside)
    }
}

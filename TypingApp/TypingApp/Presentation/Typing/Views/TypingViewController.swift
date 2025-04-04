//
//  ViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/6/25.
//

import UIKit
import Combine

final class TypingViewController: UIViewController {
    private let speedView = TypingSpeedView()
    private let typingInputAccessoryView = TypingInputAccessoryView()
    private let layeredTextView = LayeredTextView()
    
    private let viewModel: TypingViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: TypingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setSpeedView()
        setTextView()
        setupBindings()
    }
    
    private func setNavigationBar() {
        title = "하루필사"
        
        let action = UIAction { _ in
            self.viewModel.coordinator?.showHistoryView()
        }
        let historyButton = UIBarButtonItem(
            image: .iconHistory,
            primaryAction: action
        )
        navigationItem.rightBarButtonItem = historyButton
    }
    
    private func setSpeedView() {
        view.addSubview(speedView, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .height(30)])
    }
    
    private func setTextView() {
        layeredTextView.configure(with: viewModel, inputAccessoryView: typingInputAccessoryView)
        view.addSubview(layeredTextView, autoLayout: [.topNext(to: speedView, constant: 0), .leading(0), .trailing(0), .bottom(0)])
        
        let action = UIAction { _ in
            self.viewModel.coordinator?.presentLinkWebView()
        }
        typingInputAccessoryView.setLinkButtonAction(action)
    }
    
    private func setupBindings() {
        viewModel.$placeholderText
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                self.layeredTextView.setPlaceholderText(text)
            }
            .store(in: &cancellables)
        
        viewModel.$elapsedTimeString
            .receive(on: DispatchQueue.main)
            .sink { [weak self] elapsedTimeString in
                guard let self else { return }
                self.speedView.updateTimeLabel(elapsedTimeString)
            }
            .store(in: &cancellables)
        
        viewModel.$wpm
            .receive(on: DispatchQueue.main)
            .sink { [weak self] wpm in
                self?.speedView.updateWpmLabel(wpm)
            }
            .store(in: &cancellables)
        
        viewModel.$isTypingEnded
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isTypingEnded in
                if isTypingEnded {
                    let completeVM = CompleteViewModel()
                    let completeVC = CompletePopupViewController(viewModel: completeVM)
                    let navVC = UINavigationController(rootViewController: completeVC)
                    navVC.modalPresentationStyle = .overFullScreen
                    self?.present(navVC, animated: true)
                }
            }
            .store(in: &cancellables)
    }
}

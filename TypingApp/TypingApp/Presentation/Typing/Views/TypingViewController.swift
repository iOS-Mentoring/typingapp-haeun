//
//  ViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/6/25.
//

import UIKit
import Combine

final class TypingViewController: BaseViewController {
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
        
        let historyButton = UIBarButtonItem(
            image: .iconHistory,
            style: .plain,
            target: self,
            action: #selector(historyButtonTapped)
        )
        navigationItem.rightBarButtonItem = historyButton
    }
    
    @objc private func historyButtonTapped() {
        let historyViewController = HistoryViewController()
        navigationController?.pushViewController(historyViewController, animated: true)
    }
    
    private func setSpeedView() {
        view.addSubview(speedView, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .height(30)])
    }
    
    private func setTextView() {
        layeredTextView.configure(with: viewModel, placeholderText: viewModel.placeholderText, inputAccessoryView: typingInputAccessoryView)
        view.addSubview(layeredTextView, autoLayout: [.topNext(to: speedView, constant: 0), .leading(0), .trailing(0), .bottom(0)])
        
        typingInputAccessoryView.setLinkButtonAction(#selector(linkButtonTapped))
    }
    
    @objc private func linkButtonTapped() {
        viewModel.coordinator?.presentLinkWebView()
    }
    
    private func setupBindings() {
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

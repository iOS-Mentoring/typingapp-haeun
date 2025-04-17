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
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryEmphasis
        return view
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(.iconInverseDownload, for: .normal)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(.iconInverseShare, for: .normal)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    private let haruImageView: UIImageView = {
        let imageView = UIImageView(image: .illustHaruWhole)
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        view.addSubview(historyContentView, autoLayout: [.topNext(to: calendarView, constant: 20), .leading(20), .trailing(20), .bottom(0)])
        
        view.addSubview(bottomView, autoLayout: [.bottomSafeArea(0), .leading(0), .trailing(0), .height(80)])
        bottomView.addSubview(buttonStackView, autoLayout: [.leading(20), .centerY(0)])
        buttonStackView.addArrangedSubview(downloadButton)
        buttonStackView.addArrangedSubview(shareButton)
        downloadButton.autoLayout([.width(36), .height(36)])
        shareButton.autoLayout([.width(36), .height(36)])
        
        view.addSubview(haruImageView, autoLayout: [.trailing(0), .bottomSafeArea(40), .width(110), .height(140)])
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

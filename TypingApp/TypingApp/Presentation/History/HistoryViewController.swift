//
//  HistoryViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/11/25.
//

import UIKit

final class HistoryViewController: BaseViewController {
    private let calendarView = CalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setupUI()
    }
    
    private func setNavigation() {
        title = "하루 보관함"
        setupBackButton()
    }
    
    private func setupUI() {
        view.addSubview(calendarView, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .height(95)])
    }
}

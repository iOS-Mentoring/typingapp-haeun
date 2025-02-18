//
//  HistoryViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/11/25.
//

import UIKit

class HistoryViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    private func setNavigation() {
        title = "하루필사"
        setupBackButton()
    }
}

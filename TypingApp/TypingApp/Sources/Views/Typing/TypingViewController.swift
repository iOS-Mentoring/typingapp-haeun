//
//  ViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/6/25.
//

import UIKit

class TypingViewController: BaseViewController {
    let speedView = TypingSpeedView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setSpeedView()
    }

    private func setNavigationBar() {
        navigationBar.setTitle("하루필사")
        navigationBar.setRightButton(title: "", image: UIImage.iconHistory)
    }
    
    private func setSpeedView() {
        view.addSubview(speedView, autoLayout: [.topNext(to: navigationBar, constant: 0), .leading(0), .trailing(0), .height(30)])
    }
}

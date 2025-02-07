//
//  ViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/6/25.
//

import UIKit

class TypingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }

    private func setNavigationBar() {
        navigationBar.setTitle("하루필사")
        navigationBar.setRightButton(title: "", image: UIImage.iconHistory)
    }
}

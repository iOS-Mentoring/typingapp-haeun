//
//  ShareButton.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/10/25.
//

import UIKit

final class ShareButton: UIButton {
    private let image: UIImage
    private let title: String
    
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        var config = UIButton.Configuration.plain()
        config.image = image
        config.title = title
        config.baseForegroundColor = .primaryEmphasis
        config.imagePadding = 11
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 43)
        self.configuration = config
    }
}

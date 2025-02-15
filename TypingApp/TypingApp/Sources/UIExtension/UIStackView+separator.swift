//
//  UIStackView+separator.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/14/25.
//

import UIKit

public extension UIStackView {
    func addSeparators(color: UIColor = .primaryEmphasis, height: CGFloat = 1, width: CGFloat = 0.5) {
       let arrangedSubviews = self.arrangedSubviews
       
       for i in 0..<arrangedSubviews.count - 1 {
           let separator = UIView()
           separator.backgroundColor = color
           separator.autoLayout([.height(height), .width(width)])

           insertArrangedSubview(separator, at: 2 * i + 1)
       }
   }
}

//
//  UIView+border.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/14/25.
//

import UIKit

public extension UIView {
    func addBorders(edges: UIRectEdge = .all, color: UIColor = .primaryEmphasis, width: CGFloat = 1.0) {
        if edges.contains(.top) {
            let topBorder = CALayer()
            topBorder.backgroundColor = color.cgColor
            topBorder.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
            layer.addSublayer(topBorder)
        }
        
        if edges.contains(.bottom) {
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = color.cgColor
            bottomBorder.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
            layer.addSublayer(bottomBorder)
        }
        
        if edges.contains(.left) {
            let leftBorder = CALayer()
            leftBorder.backgroundColor = color.cgColor
            leftBorder.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
            layer.addSublayer(leftBorder)
        }
        
        if edges.contains(.right) {
            let rightBorder = CALayer()
            rightBorder.backgroundColor = color.cgColor
            rightBorder.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
            layer.addSublayer(rightBorder)
        }
    }
}

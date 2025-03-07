//
//  UIView+.swift
//  TypingApp
//
//  Created by Haeun Kwon on 3/6/25.
//

import UIKit

extension UIView {
    func captureImage(frame: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: frame)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}

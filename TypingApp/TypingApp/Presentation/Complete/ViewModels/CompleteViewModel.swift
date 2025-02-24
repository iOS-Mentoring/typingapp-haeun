//
//  CompleteViewModel.swift
//  TypingApp
//
//  Created by 권하은 on 2/14/25.
//

import UIKit
import Combine

final class CompleteViewModel {
    func captureImage(view: UIView, frame: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: frame)
        return renderer.image { context in
            view.layer.render(in: context.cgContext)
        }
    }
}

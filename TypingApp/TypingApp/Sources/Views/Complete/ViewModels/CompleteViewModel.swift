//
//  CompleteViewModel.swift
//  TypingApp
//
//  Created by 권하은 on 2/14/25.
//

import UIKit
import Combine

final class CompleteViewModel {
    let capturedImage = PassthroughSubject<UIImage, Never>()
    
    func captureAndSave(view: UIView, frame: CGRect) {
        let renderer = UIGraphicsImageRenderer(bounds: frame)
        let image = renderer.image { context in
            view.layer.render(in: context.cgContext)
        }
        capturedImage.send(image)
    }
}

//
//  UIColor+named.swift
//  YDUI
//
//  Created by 류연수 on 12/14/24.
//

import UIKit
import YDShare

public extension UIColor {
    
    static let primaryEmphasis: UIColor = YDShareAsset.primaryEmphasis.color
    static let inversePrimaryEmphasis: UIColor = YDShareAsset.inversePrimaryEmphasis.color
    static let primaryRed: UIColor = YDShareAsset.primaryRed.color

    static let gray300: UIColor = YDShareAsset.gray300.color
    static let gray200: UIColor = YDShareAsset.gray200.color
    static let gray100: UIColor = YDShareAsset.gray100.color
}

public extension CGColor {

    static let primaryEmphasis: CGColor = YDShareAsset.primaryEmphasis.color.cgColor
    static let inversePrimaryEmphasis: CGColor = YDShareAsset.inversePrimaryEmphasis.color.cgColor
    static let primaryRed: CGColor = YDShareAsset.primaryRed.color.cgColor

    static let gray300: CGColor = YDShareAsset.gray300.color.cgColor
    static let gray200: CGColor = YDShareAsset.gray200.color.cgColor
    static let gray100: CGColor = YDShareAsset.gray100.color.cgColor
}

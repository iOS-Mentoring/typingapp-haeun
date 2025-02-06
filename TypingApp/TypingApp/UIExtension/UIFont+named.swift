//
//  UIFont+named.swift
//  YDUI
//
//  Created by 류연수 on 2/4/25.
//

import UIKit

import YDShare

public extension UIFont {
    
    static func pretendard(type: YDFontFamily.PretendardType, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
    
    static func nanumMyeongjo(type: YDFontFamily.NanumMyeongjoType, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
}

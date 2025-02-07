//
//  UIFont+named.swift
//  YDUI
//
//  Created by 류연수 on 2/4/25.
//

import UIKit

//import YDShare

public enum FontFamily {
    public enum PretendardType: String {
        case black = "Black"
        case bold = "Bold"
        case extraBold = "ExtraBold"
        case extraLight = "ExtraLight"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
        case thin = "Thin"
        
        public func font(size: CGFloat) -> UIFont {
            UIFont(name: "Pretendard-\(self.rawValue)", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
    }
    
    public enum NanumMyeongjoType: String {
        case regular = ""
        case bold = "Bold"
        case extraBold = "ExtraBold"
        
        public func font(size: CGFloat) -> UIFont {
            UIFont(name: "NanumMyeongjoOTF\(self.rawValue)", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
    }
}

public extension UIFont {
    
    static func pretendard(type: FontFamily.PretendardType, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
    
    static func nanumMyeongjo(type: FontFamily.NanumMyeongjoType, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
}

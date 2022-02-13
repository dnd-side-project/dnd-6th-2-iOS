//
//  Font.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import UIKit

enum FontName: String {
    // 900
    case black = "Pretendard-Black"
    // 800
    case extrabold = "Pretendard-ExtraBold"
    // 700
    case bold = "Pretendard-Bold"
    // 600
    case semibold = "Pretendard-SemiBold"
    // 500
    case medium = "Pretendard-Medium"
    // 400 == normal
    case regular = "Pretendard-Regular"
    // 300
    case light = "Pretendard-Light"
    // 200
    case extralight = "Pretendard-ExtraLight"
    // 100
    case thin = "Pretendard-Thin"
}

extension UIFont {
    class func pretendard(weight: FontName, size: CGFloat) -> UIFont {
        if let font = UIFont(name: weight.rawValue, size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}

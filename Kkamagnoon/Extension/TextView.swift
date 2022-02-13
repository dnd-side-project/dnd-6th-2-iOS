//
//  TextView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import UIKit

extension UITextView {
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat, fontSize: CGFloat, fontWeight: FontName, color: UIColor) {
            if let text = text {
                let style = NSMutableParagraphStyle()
                style.maximumLineHeight = lineHeight
                style.minimumLineHeight = lineHeight

                let attributes: [NSAttributedString.Key: Any] = [
                    .paragraphStyle: style,
                    .foregroundColor: color,
                    .font: UIFont.pretendard(weight: fontWeight, size: fontSize)
                ]

                let attrString = NSAttributedString(string: text,
                                                    attributes: attributes)
                self.attributedText = attrString
            }
        }
}

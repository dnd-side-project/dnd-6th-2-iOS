//
//  Label.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(text: String?, lineHeight: Numbers) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight.rawValue
            style.minimumLineHeight = lineHeight.rawValue

            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style
            ]

            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}

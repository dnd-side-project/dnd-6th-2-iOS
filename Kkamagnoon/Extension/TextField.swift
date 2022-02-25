//
//  TextField.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/25.
//

import UIKit

public extension UITextField {

    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
}

//
//  String.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import Foundation

extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }

        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)

        return String(self[startIndex ..< endIndex])
    }
}

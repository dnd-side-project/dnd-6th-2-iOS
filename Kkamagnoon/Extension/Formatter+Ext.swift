//
//  Formatter+Ext.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/06/21.
//

import Foundation

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
}

extension Date {
    var monthMedium: String { return Formatter.monthMedium.string(from: self) }
    var hour12: String { return Formatter.hour12.string(from: self) }
    var minute0x: String { return Formatter.minute0x.string(from: self) }
    var amPM: String { return Formatter.amPM.string(from: self) }
}

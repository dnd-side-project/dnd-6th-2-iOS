//
//  File.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//

import Foundation

struct CreateRelayDTO {
    var title: String
    var tags: [String]
    var notice: String
    var headCount: Int
}

struct UpdateRelayDTO {
    var title: String?
    var tags: [String]?
    var headCount: Int?
}

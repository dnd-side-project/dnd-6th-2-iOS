//
//  RelayResponseModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/22.
//

import Foundation

struct RelayResponse: Decodable {
    var relays: [Relay]?
    var next_cursor: String?
}

struct Relay: Decodable {
    var _id: String?
    var createdAt: String?
    var articleCount: Int?
    var likeCount: Int?
    var membersCount: Int?
    var headCount: Int?
    var host: User?
    var tags: [String]?
    var title: String?
    var notice: Notice?
    // -> []
    var members: User?
}

struct Notice: Decodable {
    var _id: String?
    var notice: String?
}

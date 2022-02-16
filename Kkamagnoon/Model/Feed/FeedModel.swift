//
//  FeedModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//

import Foundation

// 옵셔널
struct FeedInfo: Decodable {
    var _id: String
    var comments: [String]
    var scrapNum: Int
    var commentNum: Int
    var likeNum: Int
    var `public`: Bool
    var state: Bool
    var keyWord: String
    var category: [String]
    var tags: [String]

    var content: String
    var title: String
    var user: String
    var createdAt: String
    var updatedAt: String?

    var __v: Int
}

extension FeedInfo {
    var id: String {
        _id
    }

    // CodingKeys
}

enum FeedStyle {
    case whole
    case subscribed
}

enum SortStyle {
    case byPopularity
    case byLatest
}

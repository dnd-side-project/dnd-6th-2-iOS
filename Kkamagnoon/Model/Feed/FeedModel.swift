//
//  FeedModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//

import Foundation

struct FeedInfo {
    var _id: String
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
    var updatedAt: String

    var __v: Int
}

struct Author {

}

//
//  FeedModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//
import Foundation
import RxDataSources

struct ArticlesResponse: Decodable {
    var articles: [Article]?
    var next_cursor: String?
}

struct Article: Decodable {
    var _id: String?
    var free: Bool?
    var comments: [Comment]?
    var scrapNum: Int?
    var commentNum: Int?
    var likeNum: Int?
    var `public`: Bool?
    var state: Bool?
    var keyWord: String?
    var category: String?
    var tags: [String]?
    var content: String?
    var title: String?
    var user: User?
    var createdAt: String?
    var updatedAt: String?
}

struct Category: Decodable {
    var _id: String?
    var user: [User]?
    var title: String?
    var articleCount: Int?
    var scrapCount: Int?
}

struct Comment: Decodable {
    var _id: String?
    var user: User?
    var article: Article?
    var content: String?
    var createAt: String?
    var updateAt: String?
}

struct User: Decodable {
    var _id: String?
    var state: Bool?
    var stampCount: Int?
    var challenge: Int?
    // TEMP: String -> ?
    var subscribeUser: [String]?
    var articles: [String]?

    // TEMP: String -> ?
    var temporary: [String]?
    var bio: String?
    var genre: [String]?
    var nickname: String?
    var password: String?
    var email: String?
    var hashedRefreshToken: String?
}

// TODO: CodingKeys
//
// extension Article: IdentifiableType, Equatable {
//    var identity: String {
//        return UUID().uuidString
//    }
// }

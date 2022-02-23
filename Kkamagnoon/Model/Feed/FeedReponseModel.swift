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
    var comments: [String]?
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
    var subscribeUser: [String]?
    var articles: [String]?
    var comments: [Comment]
    var categories: [String]?
    var followers: Int?
    var bio: String?
    var genre: [String]?
    var nickname: String?
    var password: String?
    var email: String?
    var hashedToken: String?
    var mailAuthCode: Int?
}

struct LikeResponse: Decodable {
    var _id: String?
    var user: User?
    var article: Article?
    var createdAt: String?
    var updatedAt: String?
}

struct ScrapResponse: Decodable {
    var _id: String?
    var user: User?
    var article: Article?
    var category: Category?
    var createdAt: String?
    var updatedAt: String?
}

// TODO: CodingKeys

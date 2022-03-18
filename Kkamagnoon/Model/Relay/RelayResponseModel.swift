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

struct GetRelayArticleResDTO: Decodable {
    var relayArticles: [Article]?
    var next_cursor: String?
}

struct Relay: Decodable {
    var _id: String?
    var createdAt: String?
    var articleCount: Int?
    var likeCount: Int?
    var membersCount: Int?
    var headCount: Int?
    var host: Host?
    var tags: [String]?
    var title: String?
    var notice: Notice?

}

struct Notice: Decodable {
    var _id: String?
    var notice: String?
}

struct MessageResDTO: Decodable {
    var message: String?
}

struct AddNoticeDTO: Decodable {
    var notice: String?
}

struct RelayArticleDTO: Codable {
    var content: String?
    var categoryId: String?
}

struct Host: Decodable {
    var _id: String?
    var hashedToken: String?
    var followers: Int?
    var articleCount: Int?
    var categories: [String]?
    var state: Bool?
    var stampCount: Int?
    var subscribeUser: [String]?
    var comments: [Comment]?
    var bio: String?
    var genre: [String]?
    var nickname: String?
    var password: String?
    var email: String?
}

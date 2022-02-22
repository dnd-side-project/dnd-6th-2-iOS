//
//  RelayResponseModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/22.
//

import Foundation

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
    var notice: Notice
    var members: Members?
}

struct Host: Decodable {
//    var hashedToken: ??
    var _id: String?
    var state: Bool?
    var stampCount: Int?
    var challenge: Int?
//    var subscribeUser: []
    var articles: [String]?
//    var temporary: []
    var bio: String?
    var genre: [String]?
    var nickname: String?
    var password: String?
    var email: String?
    var followers: Int?
    var hashedRefreshToken: String?
    var categories: [String]?
    var articleCount: Int?
}

struct Notice: Decodable {
    var _id: String?
    var notice: String?
}

struct Members: Decodable {
//    var hashedToken: ?
    var _id: String?
    var state: Bool?
    var stampCount: Int?
    var challenge: Int?
//    var subscribeUser:
    var articles: [String]?
//    var temporary: []
    var bio: String?
    var genre: [String]?
    var nickname: String?
    var password: String?
    var email: String?
    var followers: Int?
    var hashedRefreshToken: String?
    var categories: [String]?
    var articleCount: Int?
}

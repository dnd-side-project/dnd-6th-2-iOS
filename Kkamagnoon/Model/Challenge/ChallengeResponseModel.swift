//
//  ChallengeResponseModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/23.
//

import Foundation

struct GetChallengeMain: Decodable {
    var randomArticles: [RandomArticles]?
    var challengeCount: Int?
}

struct RandomArticles: Decodable {
    var _id: String?
    var updateDay: String?
    var state: Bool?
    var content: String?
}

struct Tip: Decodable {
    var _id: String?
    var content: String?
}

struct Keyword {
    var _id: String?
    var content: String?
    var state: Bool?
    var updateDay: String?
}

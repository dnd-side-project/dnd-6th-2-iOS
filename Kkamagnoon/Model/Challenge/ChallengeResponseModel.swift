//
//  ChallengeResponseModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/23.
//

import Foundation

struct GetChallengeMain: Decodable {
    var keyword: Keyword?
    var articles: [Article]?
    var challengeCount: Int?
    var challengeHistory: [String]?
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

struct Keyword: Decodable {
    var _id: String?
    var content: String?
    var state: Bool?
    var updateDay: String?
}

struct GetMonthlyDTO: Decodable {
    var monthlyChallengeHistory: [String]?
    var monthlyStamp: Int?
}

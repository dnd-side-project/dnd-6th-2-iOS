//
//  ChallengeEndPointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import Foundation

enum ChallengeEndPointCases: EndPoint {

    case getChallenge
    case getChallengeStamp(month: String, year: String)
    case getChallengeArticle
    case postChallengeArticle(article: CreateArticleDTO)
    case postChallengeArticleTemp(article: CreateArticleDTO)

    // 개발용
    case getChallengeKeyword
    case postChallengeKeyword(content: String)
}

extension ChallengeEndPointCases {
    var httpMethod: String {
        switch self {
        case .getChallenge:
            return "GET"
        case .getChallengeStamp:
            return "GET"
        case .getChallengeArticle:
            return "GET"
        case .postChallengeArticle:
            return "POST"
        case .postChallengeArticleTemp:
            return "POST"
        case .getChallengeKeyword:
            return "GET"
        case .postChallengeKeyword:
            return "POST"
        }
    }
}

extension ChallengeEndPointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/challenge"
    }
}

extension ChallengeEndPointCases {
    var path: String {
        switch self {
        case .getChallenge:
            return baseURLString
        case .getChallengeStamp(let month, let year):
            return baseURLString + "/\(month)/\(year)"
        case .getChallengeArticle:
            return baseURLString + "/article"
        case .postChallengeArticle:
            return baseURLString + "/article"
        case .postChallengeArticleTemp:
            return baseURLString + "/article/temp"
        case .getChallengeKeyword:
            return baseURLString + "/keyword"
        case .postChallengeKeyword:
            return baseURLString + "/keyword"
        }
    }
}

extension ChallengeEndPointCases {
    var headers: [String: Any]? {
        guard let token = TokenUtils.shared.read(account: .accessToken) else {
            return nil
        }

        return [
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer \(token)"
        ]
    }
}

extension ChallengeEndPointCases {
    var body: [String: Any]? {
        switch self {
        case .postChallengeArticle(article: let article):
            return [
                "title": article.title,
                "content": article.content,
                "tags": article.tags ?? [],
                "public": article.public,
                "category": article.category
            ]

        case .postChallengeArticleTemp(article: let article):
            return [
                "title": article.title,
                "content": article.content,
                "tags": article.tags ?? [],
                "public": article.public,
                "category": article.category
            ]

        case .postChallengeKeyword(content: let content):
            return [
                "content": content
            ]

        default:
            return [:]
        }

    }
}

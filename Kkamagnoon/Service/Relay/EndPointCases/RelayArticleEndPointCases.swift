//
//  RelayArticleEndPointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation

enum RelayArticleEndPointCases: EndPoint {

    case getRelayArticle(relayId: String, cursor: String?)
    case postRelayArticle(relayId: String, content: String)
    case patchRelatArticle(relayId: String, articleId: String, content: String)
    case deleteRelayArticle(relayId: String, articleId: String)
}

extension RelayArticleEndPointCases {
    var httpMethod: String {
        switch self {
        case .getRelayArticle:
            return "GET"
        case .postRelayArticle:
            return "POST"
        case .patchRelatArticle:
            return "PATCH"
        case .deleteRelayArticle:
            return "DELETE"
        }
    }
}

extension RelayArticleEndPointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/relay"
    }
}

extension RelayArticleEndPointCases {
    var path: String {
        switch self {
        case .getRelayArticle(let relayId, let cursor):
            var finalUrl = baseURLString + "/\(relayId)/article"
            if let cursor = cursor {
                finalUrl.append(contentsOf: "?cursor=\(cursor)")
            }
            return finalUrl

        case .postRelayArticle(let relayId, _):
            return baseURLString + "/\(relayId)/article"

        case .patchRelatArticle(let relayId, let articleId, _):
            return baseURLString + "/\(relayId)/article/\(articleId)"
        case .deleteRelayArticle(let relayId, let articleId):
            return baseURLString + "/\(relayId)/article/\(articleId)"
        }
    }
}

extension RelayArticleEndPointCases {
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

extension RelayArticleEndPointCases {
    var body: [String: Any]? {
        switch self {
        case .postRelayArticle(_, content: let content):
            return [
                "content": content
            ]

        case .patchRelatArticle(_, _, content: let content):
            return [
                "content": content
            ]

        default:
            return [:]
        }
    }
}

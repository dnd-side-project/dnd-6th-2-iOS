//
//  FeedSubscribeEndpointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//

import Foundation

enum FeedSubscribeEndpointCases: EndPoint {

    case getSubscribeFeed(cursor: String?)
    case getSubscribeAuthorList
    case getSubscribeFeedByAuthor(cursor: String?, authorId: String)
    case patchSubscribe(authorId: String)
    case patchSubscribeCancel(authorId: String)

}

extension FeedSubscribeEndpointCases {
    var httpMethod: String {
        switch self {
        case .getSubscribeFeed:
            return "GET"
        case .getSubscribeAuthorList:
            return "GET"
        case .getSubscribeFeedByAuthor:
            return "GET"
        case .patchSubscribe:
            return "PATCH"
        case .patchSubscribeCancel:
            return "PATCH"
        }
    }
}

extension FeedSubscribeEndpointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/feed/subscribe"
    }
}

extension FeedSubscribeEndpointCases {
    var path: String {
        switch self {
        case .getSubscribeFeed(let cursor):
            var finalUrl = baseURLString
            if let cursor = cursor {
                finalUrl.append(contentsOf: "?cursor=\(cursor)")
            }

            return finalUrl

        case .getSubscribeAuthorList:
            return baseURLString + "authorlist"

        case .getSubscribeFeedByAuthor(let cursor, let authorId):
            var finalUrl = baseURLString + "/\(authorId)"

            if let cursor = cursor {
                finalUrl.append(contentsOf: "?cursor=\(cursor)")
            }

            return finalUrl

        case .patchSubscribe(let authorId):
            return baseURLString + "/\(authorId)"

        case .patchSubscribeCancel(let authorId):
            return baseURLString + "/\(authorId)/cancel"
        }
    }
}

extension FeedSubscribeEndpointCases {
    var headers: [String: Any]? {
        guard let token = TokenUtils.shared.read(account: .accessToken) else {
            return nil
        }

        return [
            "Content-Type": "application/json",
            "accept": "*/*",
            "Authorization": "Bearer \(token)"
        ]
    }
}

extension FeedSubscribeEndpointCases {
    var body: [String: Any]? {
        switch self {
//        case .postComment(content: let content):
//            return ["content": content]

        default:
            return [:]
        }

    }
}

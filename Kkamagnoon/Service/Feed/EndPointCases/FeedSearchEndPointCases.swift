//
//  FeedSearchEndpointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//
import Foundation

enum FeedSearchEndpointCases: EndPoint {

    case getSearchFeed(cursor: String?, content: String, option: String, type: String?, orderBy: String)
    case getSearchFeedHistory
    case deleteSearchFeedHistory(id: String)

}

extension FeedSearchEndpointCases {
    var httpMethod: String {
        switch self {
        case .getSearchFeed:
            return "GET"
        case .getSearchFeedHistory:
            return "GET"
        case .deleteSearchFeedHistory:
            return "DELETE"
        }
    }
}

extension FeedSearchEndpointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/feed/search"
    }
}

extension FeedSearchEndpointCases {
    var path: String {
        switch self {
        case .getSearchFeed(let cursor, let content, let option, let type, let orderBy):
            var finalUrl = baseURLString + "?content=\(content)&option=\(option)&orderBy=\(orderBy)"

            if let cursor = cursor {
                finalUrl.append("&cursor=\(cursor)")
            }

            if let type = type {
                finalUrl.append("&type=\(type)")
            }
            return finalUrl

        case .getSearchFeedHistory:
            return baseURLString + "/history"

        case .deleteSearchFeedHistory(let id):
            return baseURLString + "/history/\(id)"
        }
    }
}

extension FeedSearchEndpointCases {
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

extension FeedSearchEndpointCases {
    var body: [String: Any]? {
        switch self {
//        case .postComment(content: let content):
//            return ["content": content]
        default:
            return [:]
        }

    }
}

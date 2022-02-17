//
//  FeedCommentEndpointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//

import Foundation

enum FeedCommentEndpointCases: EndPoint {

    case postComment(articleId: String, content: String)
    case patchComment(articleId: String, commentId: String, content: String)
    case deleteComment(articleId: String, commentId: String)

}

extension FeedCommentEndpointCases {
    var httpMethod: String {
        switch self {
        case .postComment:
            return "POST"
        case .patchComment:
            return "PATCH"
        case .deleteComment:
            return "DELETE"
        }
    }
}

extension FeedCommentEndpointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/feed"
    }
}

extension FeedCommentEndpointCases {
    var path: String {
        switch self {
        case .postComment(let articleId, _):
            return baseURLString + "/\(articleId)/comment"
            
        case .patchComment(let articleId, let commentId, _):
            return baseURLString + "/\(articleId)/comment/\(commentId)"
        case .deleteComment(let articleId, let commentId):
            return baseURLString + "/\(articleId)/comment/\(commentId)"
        }
    }
}

extension FeedCommentEndpointCases {
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

extension FeedCommentEndpointCases {
    var body: [String: Any]? {
        switch self {
//        case .postComment(content: let content):
//            return ["content": content]

        default:
            return [:]
        }

    }
}


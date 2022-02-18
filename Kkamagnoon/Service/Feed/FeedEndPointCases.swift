//
//  FeedEndPointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/12.
//

import Foundation

enum FeedEndpointCases: EndPoint {

    case getWholeFeed(page: Int)
    case getSubscribeFeed(page: Int)
    case getSubscribeAuthorList
    case getSubscribeFeedBySelectedAuthor(page: Int, authorId: String)
    case patchSubscribe(authorId: String)
    case patchSubscribeCancel(authorId: String)
    case getSearchFeed(content: String, option: String)
    case getArticle(articleId: String)
    case deleteArticle(articleId: String)
    case patchArticle(articleId: String)
    case postComment(articleId: String, content: String)
    case patchComment(commentId: String)
    case deleteComment(commentId: String)
    case postScrap(articleId: String)
    case deleteScrap(articleId: String)
    case postLike(articleId: String)
    case deleteLike(articleId: String)

}

extension FeedEndpointCases {
    var httpMethod: String {
        switch self {
        case .getWholeFeed:
            return "GET"
        case .getSubscribeFeed:
            return "GET"
        case .getSubscribeAuthorList:
            return "GET"
        case .getSubscribeFeedBySelectedAuthor:
            return "GET"
        case .patchSubscribe:
            return "PATCH"
        case .patchSubscribeCancel:
            return "PATCH"
        case .getSearchFeed:
            return "GET"
        case .getArticle:
            return "GET"
        case .deleteArticle:
            return "DELETE"
        case .patchArticle:
            return "PATCH"
        case .postComment:
            return "POST"
        case .patchComment:
            return "PATCH"
        case .deleteComment:
            return "DELETE"
        case .postScrap:
            return "POST"
        case .deleteScrap:
            return "DELETE"
        case .postLike:
            return "POST"
        case .deleteLike:
            return "DELETE"
        }
    }
}

extension FeedEndpointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/feed"
    }
}

extension FeedEndpointCases {
    var path: String {
        switch self {
        case .getWholeFeed(page: let page):
            return "?page=\(page)"
        case .getSubscribeFeed(page: let page):
            return "/subscribe?page=\(page)"
        case .getSubscribeAuthorList:
            return "/subscribe/authorlist"
        case .getSubscribeFeedBySelectedAuthor(page: let page, authorId: let authorId):
            return "/subscribe/\(authorId)?page=\(page)"
        case .patchSubscribe(authorId: let authorId):
            return "/subscribe/\(authorId)"
        case .patchSubscribeCancel(authorId: let authorId):
            return "/subscribe-cancel/\(authorId)"
        case .getSearchFeed(content: let content, option: let option):
            return "/search?content=\(content)&option=\(option)"
        case .getArticle(articleId: let articleId):
            return "/\(articleId)"
        case .deleteArticle(articleId: let articleId):
            return "/\(articleId)"
        case .patchArticle(articleId: let articleId):
            return "/\(articleId)"
        case .postComment(articleId: let articleId):
            return "/\(articleId)"
        case .patchComment(commentId: let commentId):
            return "/comment/\(commentId)"
        case .deleteComment(commentId: let commentId):
            return "/comment/\(commentId)"
        case .postScrap(articleId: let articleId):
            return "/scrap/\(articleId)"
        case .deleteScrap(articleId: let articleId):
            return "/scrap/\(articleId)"
        case .postLike(articleId: let articleId):
            return "/like/\(articleId)"
        case .deleteLike(articleId: let articleId):
            return "/like/\(articleId)"
        }
    }
}

extension FeedEndpointCases {
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

extension FeedEndpointCases {
    var body: [String: Any]? {
        switch self {
        case .postComment(content: let content):
            return ["content": content]

        default:
            return [:]
        }

    }
}

//
//  FeedEndPointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/12.
//
import Foundation

enum FeedEndpointCases: EndPoint {

    case getWholeFeed(cursor: String?, orderBy: String, tags: [String]?)
    case getArticle(articleId: String)
    case deleteArticle(articleId: String)
    case patchArticle(articleId: String, articleInfo: CreateArticleDTO)
    case postScrap(articleId: String, scrap: ScrapDTO)
    case deleteScrap(articleId: String)
    case postLike(articleId: String, like: ScrapDTO)
    case deleteLike(articleId: String)
}

extension FeedEndpointCases {
    var httpMethod: String {
        switch self {
        case .getWholeFeed:
            return "GET"
        case .getArticle:
            return "GET"
        case .deleteArticle:
            return "DELETE"
        case .patchArticle:
            return "PATCH"
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
        case .getWholeFeed(let cursor, let orderBy, let tags):
            var finalUrl = baseURLString + "?orderBy=\(orderBy)"
            if let cursor = cursor {
                finalUrl.append("&cursor=\(cursor)")
            }

            if let tags = tags {
                finalUrl.append("&tags=\(tags)")
            }

            return finalUrl

        case .getArticle(let articleId):
            return baseURLString + "/\(articleId)"

        case .deleteArticle(let articleId):
            return baseURLString + "/\(articleId)"

        case .patchArticle(let articleId, _):
            return baseURLString + "/\(articleId)"

        case .postScrap(let articleId, _):
            return baseURLString + "/\(articleId)/scrap"

        case .deleteScrap(let articleId):
            return baseURLString + "/\(articleId)/scrap"

        case .postLike(let articleId, _):
            return baseURLString + "/\(articleId)/like"

        case .deleteLike(let articleId):
            return baseURLString + "/\(articleId)/like"
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
            "accept": "*/*",
            "Authorization": "Bearer \(token)"
        ]
    }
}

extension FeedEndpointCases {
    var body: [String: Any]? {
        switch self {
        case .patchArticle(_, articleInfo: let articleInfo):

            return [
                "title": articleInfo.title,
                "content": articleInfo.content,
                "tags": articleInfo.tags ?? [],
                "public": articleInfo.public
            ]

        case .postScrap(_, scrap: let scrap):

            // TODO: scrapDTO
            return [:]

        case .postLike(_, like: let like):

            // TODO: scrapDTO
            return [:]

        default:
            return [:]
        }

    }
}

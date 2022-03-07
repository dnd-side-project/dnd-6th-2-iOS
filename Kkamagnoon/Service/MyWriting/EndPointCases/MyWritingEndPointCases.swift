//
//  MyWritingEndPointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/24.
//

import Foundation

enum MyWritingEndPointCases: EndPoint {

    case getMyArticle(cursor: String?, type: String?)
    case postMyArticleFree(article: CreateArticleDTO)
    case postMyArticleTemp(article: CreateArticleDTO)
    case getMyArticleTemp(cursor: String?)
    case getMyArticleDetail(articleId: String)
    case patchMyArticle(articleId: String, article: CreateArticleDTO)
    case deleteMyArticle(articleIdArr: [String])

}

extension MyWritingEndPointCases {
    var httpMethod: String {
        switch self {
        case .getMyArticle:
            return "GET"
        case .postMyArticleFree:
            return "POST"
        case .postMyArticleTemp:
            return "POST"
        case .getMyArticleTemp:
            return "GET"
        case .getMyArticleDetail:
            return "GET"
        case .patchMyArticle:
            return "PATCH"
        case .deleteMyArticle:
            return "DELETE"
        }
    }
}

extension MyWritingEndPointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/my-article"
    }
}

extension MyWritingEndPointCases {
    var path: String {
        switch self {
        case .getMyArticle(let cursor, let type):
            var finalString = baseURLString

            if let cursor = cursor {
                finalString.append("?cursor=\(cursor)")
            }

            if let type = type {
                finalString.append("?type=\(type)")
            }

            return finalString

        case .postMyArticleFree:
            return baseURLString + "/free"

        case .postMyArticleTemp:
            return baseURLString + "/temp"

        case .getMyArticleTemp(let cursor):
            var finalString = baseURLString + "/temp"

            if let cursor = cursor {
                finalString.append("?cursor=\(cursor)")
            }

            return finalString

        case .getMyArticleDetail(let articleId):
            return baseURLString + "/\(articleId)"

        case .patchMyArticle(let articleId, _):
            return baseURLString + "/\(articleId)"

        case .deleteMyArticle(let articleIdArr):
            var finalUrl = baseURLString + "/\(articleIdArr[0])"
            for index in 1..<articleIdArr.count {
                finalUrl.append(",\(articleIdArr[index])")
            }
            return finalUrl
        }
    }
}

extension MyWritingEndPointCases {
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

extension MyWritingEndPointCases {
    var body: [String: Any]? {
        switch self {
        case .postMyArticleFree(article: let article):
            return [
                "title": article.title ?? "",
                "content": article.content ?? "",
                "tags": article.tags ?? [],
                "public": article.public ?? false,
                "category": article.category ?? ""
            ]

        case .postMyArticleTemp(article: let article):
            return [
                "title": article.title ?? "",
                "content": article.content ?? "",
                "tags": article.tags ?? [],
                "public": article.public ?? false,
                "category": article.category ?? ""
            ]

        case .patchMyArticle(_, article: let article):

            var body: [String: Any] = [:]
            if let title = article.title {
                body.updateValue(title, forKey: "title")
            }
            if let content = article.content {
                body.updateValue(content, forKey: "content")
            }
            if let tags = article.tags {
                body.updateValue(tags, forKey: "tags")
            }
            if let `public` = article.public {
                body.updateValue(`public`, forKey: "public")
            }
            if let category = article.category {
                body.updateValue(category, forKey: "category")
            }

            return body

        default:
            return [:]
        }

    }
}

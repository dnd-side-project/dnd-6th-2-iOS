//
//  RelayEndPointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation

enum RelayEndPointCases: EndPoint {

    case getRelayRoomList(cursor: String?, orderBy: String, tags: [String]?)
    case postRelayRoom(relay: CreateRelayDTO)
    case getRelayRoomParticitated(cursor: String?)
    case patchRelayRoom(relayId: String, updateRelay: UpdateRelayDTO)
    case deleteRelayRoom(relayId: String)
    case postRelayJoin(relayId: String)
    case deleteRelayJoin(relayId: String)

}

extension RelayEndPointCases {
    var httpMethod: String {
        switch self {
        case .getRelayRoomList:
            return "GET"
        case .postRelayRoom:
            return "POST"
        case .getRelayRoomParticitated:
            return "GET"
        case .patchRelayRoom:
            return "PATCH"
        case .deleteRelayRoom:
            return "DELETE"
        case .postRelayJoin:
            return "POST"
        case .deleteRelayJoin:
            return "DELETE"
        }
    }
}

extension RelayEndPointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/relay"
    }
}

extension RelayEndPointCases {
    var path: String {
        switch self {
        case .getRelayRoomList(let cursor, let orderBy, let tags):
            var finalUrl = baseURLString + "?orderBy=\(orderBy)"
            if let cursor = cursor {
                finalUrl.append(contentsOf: "&cursor=\(cursor)")
            }

            if let tags = tags {
                finalUrl.append(contentsOf: "&tags=\(tags)")
            }

            return finalUrl

        case .postRelayRoom:
            return baseURLString

        case .getRelayRoomParticitated(let cursor):
            var finalUrl = baseURLString + "/user"

            if let cursor = cursor {
                finalUrl.append(contentsOf: "?cursor=\(cursor)")
            }

            return finalUrl

        case .patchRelayRoom(let relayId, _):
            return baseURLString + "/\(relayId)"

        case .deleteRelayRoom(let relayId):
            return baseURLString + "/\(relayId)"

        case .postRelayJoin(let relayId):
            return baseURLString + "/\(relayId)/join"
        case .deleteRelayJoin(let relayId):
            return baseURLString + "/\(relayId)/join"
        }
    }
}

extension RelayEndPointCases {
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

extension RelayEndPointCases {
    var body: [String: Any]? {
        switch self {
        case .postRelayRoom(relay: let relay):
            return [
                "title": relay.title,
                "tags": relay.tags,
                "notice": relay.notice,
                "headCount": relay.headCount
            ]

        case .patchRelayRoom(_, updateRelay: let updateRelay):
            var body: [String: Any] = [:]

            if let title = updateRelay.title {
                body["title"] = title
            }

            if let tags = updateRelay.tags {
                body["tags"] = tags
            }

            if let headCount = updateRelay.headCount {
                body["headCount"] = headCount
            }
            return body

        default:
            return [:]
        }

    }
}

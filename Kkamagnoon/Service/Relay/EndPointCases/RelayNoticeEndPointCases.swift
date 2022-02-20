//
//  RelayNoticeEndPointCases.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation

enum RelayNoticeEndPointCases: EndPoint {

    case postRelayNotice(relayId: String, notice: String)
    case patchRelatNotice(relayId: String, noticeId: String, notice: String)
    case deleteRelayNotice(relayId: String, noticeId: String)
}

extension RelayNoticeEndPointCases {
    var httpMethod: String {
        switch self {
        case .postRelayNotice:
            return "POST"
        case .patchRelatNotice:
            return "PATCH"
        case .deleteRelayNotice:
            return "DELETE"
        }
    }
}

extension RelayNoticeEndPointCases {
    var baseURLString: String {
        return "http://15.164.99.32:3000/relay"
    }
}

extension RelayNoticeEndPointCases {
    var path: String {
        switch self {
        case .postRelayNotice(let relayId, _):
            return baseURLString + "/\(relayId)/notice"

        case .patchRelatNotice(let relayId, let noticeId, _):
            return baseURLString + "/\(relayId)/notice/\(noticeId)"
        case .deleteRelayNotice(let relayId, let noticeId):
            return baseURLString + "/\(relayId)/notice/\(noticeId)"
        }
    }
}

extension RelayNoticeEndPointCases {
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

extension RelayNoticeEndPointCases {
    var body: [String: Any]? {
        switch self {
        case .postRelayNotice(_, notice: let notice):
            return [
                "notice": notice
            ]

        case .patchRelatNotice(_, _, notice: let notice):
            return [
                "notice": notice
            ]

        default:
            return [:]
        }
    }
}

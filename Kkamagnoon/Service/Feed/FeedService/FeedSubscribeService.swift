//
//  FeedSubscribeService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//
import Foundation

class FeedSubscribeService: Service {
    func getSubscribeFeed(cursor: String?) {
        let endpoint = FeedSubscribeEndpointCases.getSubscribeFeed(cursor: cursor)
        let request = makeRequest(endpoint: endpoint)
    }

    func getSubscribeAuthorList() {
        let endpoint = FeedSubscribeEndpointCases.getSubscribeAuthorList
        let request = makeRequest(endpoint: endpoint)
    }

    func getSubscribeFeedByAuthor(cursor: String?, authorId: String) {
        let endpoint = FeedSubscribeEndpointCases.getSubscribeFeedByAuthor(cursor: cursor, authorId: authorId)
        let request = makeRequest(endpoint: endpoint)
    }

    func patchSubscribe(authorId: String) {
        let endpoint = FeedSubscribeEndpointCases.patchSubscribe(authorId: authorId)
        let request = makeRequest(endpoint: endpoint)
    }

    func patchSubscribeCancel(authorId: String) {
        let endpoint = FeedSubscribeEndpointCases.patchSubscribeCancel(authorId: authorId)
        let request = makeRequest(endpoint: endpoint)
    }

}

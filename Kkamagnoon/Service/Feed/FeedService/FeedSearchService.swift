//
//  FeedSearchService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//
import Foundation

class FeedSearchService: Service {
    func getSearchFeed(cursor: String?, content: String, option: String) {
        let endpoint = FeedSearchEndpointCases.getSearchFeed(cursor: cursor, content: content, option: option)
        let request = makeRequest(endpoint: endpoint)
    }

    func getSearchFeedHistory() {
        let endpoint = FeedSearchEndpointCases.getSearchFeedHistory
        let request = makeRequest(endpoint: endpoint)
    }

    func deleteSearchFeedHistory(id: String) {
        let endpoint = FeedSearchEndpointCases.deleteSearchFeedHistory(id: id)
        let request = makeRequest(endpoint: endpoint)
    }

}

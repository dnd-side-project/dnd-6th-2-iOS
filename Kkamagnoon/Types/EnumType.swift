//
//  RelayEnum.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation

enum RelayListStyle {
    case relayRoom
    case participatedRoom
}

enum SortStyle: String {
    case byPopularity = "인기순"
    case byLatest = "최신순"
}

enum RelayRoomState {
    case nonParticipation
    case participation
}

enum FeedStyle {
    case whole
    case subscribed
}

enum SubscribeStyle {
    case subscribing
    case notSubscribing
}

enum SearchContentStyle {
    case history
    case searchResult
}

enum MyWritingStyle {
    case myWriting
    case tempWriting
}

enum CalendarState {
    case month
    case week
}

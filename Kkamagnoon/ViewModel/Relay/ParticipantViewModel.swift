//
//  ParticipantViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxSwift
import RxCocoa

class ParticipantViewModel: ViewModelType {
    struct Input {
        let relayRoomButtonTap = PublishSubject<Void>()
        let participatedRoomButtonTap = PublishSubject<Void>()
        let bellButtonTap = PublishSubject<Void>()
        let tagCellTap = PublishSubject<Void>()
        let sortButtonTap = PublishSubject<Void>()
        // Temp
        let relayRoomCellTap = PublishSubject<IndexPath>()
        let makingRoomButtonTap = PublishSubject<Void>()
        // add more...
    }

    struct Output {
        let showError = PublishRelay<Error>()
        
        let currentListStyle = BehaviorRelay<RelayListStyle>(value: .relayRoom)

        let goToBell = PublishRelay<Void>()
        let currentSortStyle = BehaviorRelay<SortStyle>(value: .byLatest)
        let goToDetailRelayRoom = PublishRelay<IndexPath>()
        let goToMakingRelay = PublishRelay<Void>()

        // TEMP String -> FeedInfo
        let relayRoomList = BehaviorRelay<[String]>(value: [])
        let participatedRoomList = BehaviorRelay<[String]>(value: [])
    }

    var input: Input
    var output: Output

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

    }
}

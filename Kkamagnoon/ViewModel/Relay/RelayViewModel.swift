//
//  RelayViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class RelayViewModel: ViewModelType {

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
        let currentListStyle = BehaviorRelay<RelayListStyle>(value: .relayRoom)

        let goToBell = PublishRelay<Void>()
        let currentSortStyle = BehaviorRelay<SortStyle>(value: .byLatest)
        let goToDetailRelayRoom = PublishRelay<IndexPath>()
        let goToMakingRelay = PublishRelay<Void>()

        // TEMP String -> FeedInfo
        let relayRoomList = BehaviorRelay<[SectionModel<String, String>]>(value: [])
        let participatedRoomList = BehaviorRelay<[String]>(value: [])
    }

    var input: Input
    var output: Output
//    var service: FeedService!

    var disposeBag = DisposeBag()
    var sortStyle: SortStyle = .byLatest

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
//        self.service = FeedService()

        bindChangeRelayList()
        bindExtraButton()
        bindSortButton()
        bindMakingRelayButton()
        bindRelayRoomList()
        bindRelayListTap()
        bindParticipatedRoomList()
    }

    func bindChangeRelayList() {
        input.relayRoomButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.currentListStyle.accept(.relayRoom)
            }
            .disposed(by: disposeBag)

        input.participatedRoomButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.currentListStyle.accept(.participatedRoom)
            }
            .disposed(by: disposeBag)
    }

    func bindExtraButton() {

        input.bellButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToBell.accept(())
            }
            .disposed(by: disposeBag)
    }

    func bindSortButton() {
        input.sortButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                if owner.sortStyle == .byLatest {
                    owner.output.currentSortStyle.accept(.byPopularity)
                    owner.sortStyle = .byPopularity
                } else {
                    owner.output.currentSortStyle.accept(.byLatest)
                    owner.sortStyle = .byLatest
                }
            }
            .disposed(by: disposeBag)
    }

    func bindMakingRelayButton() {
        input.makingRoomButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToMakingRelay.accept(())
            }
            .disposed(by: disposeBag)
    }

    func bindRelayRoomList() {
        // DUMMY

        Observable.just([SectionModel(model: "최신순", items: ["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])])
            .bind { [weak self] list in
                guard let self = self else {return}
                self.output.relayRoomList.accept(list)
            }
            .disposed(by: disposeBag)

    }

    func bindRelayListTap() {
        input.relayRoomCellTap
            .bind { [weak self] indexPath in
                guard let self = self else {return}
                self.output.goToDetailRelayRoom.accept(indexPath)
            }
            .disposed(by: disposeBag)
    }

    func bindParticipatedRoomList() {
        // DUMMY
        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "긴 글", "무서운 글", "한글", "세종대왕"])
        dummyData.bind { [weak self] list in
            guard let self = self else {return}
            self.output.participatedRoomList.accept(list)
        }
        .disposed(by: disposeBag)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

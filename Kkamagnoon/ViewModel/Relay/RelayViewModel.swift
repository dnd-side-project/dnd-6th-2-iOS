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
        let tagCellTap = PublishSubject<String>()
        let sortButtonTap = PublishSubject<Void>()
        let relayRoomCellTap = PublishSubject<Relay>()
        let makingRoomButtonTap = PublishSubject<Void>()
    }

    struct Output {
        let currentListStyle = BehaviorRelay<RelayListStyle>(value: .relayRoom)
        let goToBell = PublishRelay<Void>()
        let currentSortStyle = BehaviorRelay<SortStyle>(value: .byLatest)
        let goToDetailRelayRoom = PublishRelay<Relay>()
        let goToMakingRelay = PublishRelay<Void>()
        let relayRoomList = PublishRelay<[RelaySection]>()
        let participatedRoomList = PublishRelay<[RelaySection]>()
    }

    var input: Input
    var output: Output

    var relayService: RelayService!
    var disposeBag = DisposeBag()

    var sortStyle: SortStyle = .byPopularity
    var checkSelectedTags = [String: Bool]()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        self.relayService = RelayService()

        StringType.categories.forEach({ tag in
            checkSelectedTags.updateValue(false, forKey: tag)
        })

        bind()
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension RelayViewModel {
    func bindRelayList() {

        relayService.getRelayRoomList(cursor: nil, orderBy: sortStyle.rawValue, tags: checkSelectedTags)
            .withUnretained(self)
            .bind { owner, relayResponse in

                owner.output.relayRoomList.accept(
                    [RelaySection(header: "", items: relayResponse.relays ?? [])]
                )
            }
            .disposed(by: disposeBag)
    }

    func bindParticipatedRoomList() {
        relayService.getRelayRoomParticitated(cursor: nil)
            .withUnretained(self)
            .bind { owner, relayResponse in

                owner.output.participatedRoomList.accept(
                    [RelaySection(header: "", items: relayResponse.relays ?? [])]
                )
            }
            .disposed(by: disposeBag)
    }

    func bindMyRoomList() {
        relayService.getRelayUserMade(cursor: nil)
            .withUnretained(self)
            .bind { owner, relayResponse in

                owner.output.participatedRoomList.accept(
                    [RelaySection(header: "", items: relayResponse.relays ?? [])]
                )
            }
            .disposed(by: disposeBag)
    }

    func bind() {
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

        input.bellButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToBell.accept(())
            }
            .disposed(by: disposeBag)

        input.tagCellTap
            .withUnretained(self)
            .bind { owner, tagString in
                let nowValue = owner.checkSelectedTags[tagString, default: false]
                owner.checkSelectedTags.updateValue(!nowValue, forKey: tagString)
                owner.bindRelayList()
            }
            .disposed(by: disposeBag)

        input.makingRoomButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToMakingRelay.accept(())
            }
            .disposed(by: disposeBag)

        input.relayRoomCellTap
            .bind { [weak self] relay in
                guard let self = self else {return}
                self.output.goToDetailRelayRoom.accept(relay)
            }
            .disposed(by: disposeBag)
    }
}

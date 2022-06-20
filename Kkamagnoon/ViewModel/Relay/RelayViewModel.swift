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
        let showError = PublishRelay<Error>()
        
        let goToBell = PublishRelay<Void>()
        let goToDetailRelayRoom = PublishRelay<Relay>()
        let goToMakingRelay = PublishRelay<Void>()

        let currentListStyle = BehaviorRelay<RelayListStyle>(value: .relayRoom)
        let currentSortStyle = BehaviorRelay<SortStyle>(value: .byLatest)

        let relayRoomList = BehaviorRelay<[RelaySection]>(value: [])
        let participatedRoomList = BehaviorRelay<[RelaySection]>(value: [])
        let tagList = Observable<[String]>.of(StringType.categories)
    }

    var input: Input
    var output: Output

    var relayService: RelayService!
    var disposeBag = DisposeBag()

    var checkSelectedTags = [String: Bool]()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        self.relayService = RelayService()

        StringType.categories.forEach({ tag in
            checkSelectedTags.updateValue(false, forKey: tag)
        })

        bindWork()
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension RelayViewModel {
    func bindWork() {
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
            .withUnretained(self)
            .bind { owner, relay in
                owner.output.goToDetailRelayRoom.accept(relay)
            }
            .disposed(by: disposeBag)

        input.sortButtonTap
            .bind(onNext: bindRelayList)
            .disposed(by: disposeBag)

    }

    func bindRelayList() {

        relayService.getRelayRoomList(cursor: nil,
                                      orderBy: output.currentSortStyle.value.rawValue,
                                      tags: checkSelectedTags)
            .withUnretained(self)
            .subscribe(onNext: { owner, relayResponse in

                owner.output.relayRoomList.accept(
                    [RelaySection(header: "", items: relayResponse.relays ?? [])]
                )
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }

    func bindParticipatedRoomList() {
        relayService.getRelayRoomParticitated(cursor: nil)
            .withUnretained(self)
            .subscribe(onNext: { owner, relayResponse in
                owner.output.participatedRoomList.accept(
                    [RelaySection(header: "", items: relayResponse.relays ?? [])]
                )
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }

    func bindMyRoomList() {
        relayService.getRelayUserMade(cursor: nil)
            .withUnretained(self)
            .subscribe(onNext: { owner, relayResponse in
                owner.output.participatedRoomList.accept(
                    [RelaySection(header: "", items: relayResponse.relays ?? [])]
                )
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }
}

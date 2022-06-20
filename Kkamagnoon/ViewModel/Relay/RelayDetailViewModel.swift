//
//  RelayDetailViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class RelayDetailViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    var isNew: Bool = false
    var didEntered: Bool = false
    var relayInfo: Relay?
    var articleList: [Article]?

    struct Input {
        let enterButtonTap = PublishSubject<Void>()
        let participantButtonTap = PublishSubject<Void>()
        let addWritingButtonTap = PublishSubject<Void>()
        let relayInfo = PublishSubject<Relay>()
    }

    struct Output {
        let showError = PublishRelay<Error>()

        let goToRoom = PublishRelay<Void>()
        let goToWriting = PublishRelay<[Article]>()
        let goToParticipantView = PublishRelay<Void>()
        let articleList = BehaviorRelay<[FeedSection]>(value: [])
    }

    var input: Input
    var output: Output

    var relayArticleService = RelayArticleService()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        bindRelayInfo()
        bindEnterRoom()
        bindAddWritingButton()
        bindParticipant()
    }

    private var currentViewState: RelayRoomState = .nonParticipation

    func bindEnterRoom() {
        input.enterButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToRoom.accept(())
            }
            .disposed(by: disposeBag)
    }

    func bindAddWritingButton() {
        input.addWritingButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToWriting.accept(owner.articleList ?? [])
            }
            .disposed(by: disposeBag)
    }

    func bindParticipant() {
        input.participantButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToParticipantView.accept(())
            }
            .disposed(by: disposeBag)
    }

    func bindRelayInfo() {
        input.relayInfo
            .withUnretained(self)
            .subscribe(onNext: { owner, relay in
                // article 조회
                owner.relayArticleService.getRelayArticle(relayId: relay._id ?? "", cursor: nil)
                    .bind { articleList in

                        let list = articleList.relayArticles ?? []

                        owner.output.articleList
                            .accept([FeedSection(header: relay, items: list)])
                        owner.articleList = list
                    }
                    .disposed(by: owner.disposeBag)
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }
}

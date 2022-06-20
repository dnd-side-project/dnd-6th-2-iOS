//
//  MyWritingViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class MyWritingViewModel: ViewModelType {
    struct Input {
        let myWritingTap = PublishSubject<Void>()
        let tempWritingTap = PublishSubject<Void>()
        let tagTap = PublishSubject<String>()
        let addWritingButtonTap = PublishSubject<Void>()
        let myWritingCellTap = PublishSubject<Article>()
//        let tempWritingCellTap = PublishSubject<Article>()

    }

    struct Output {
        let goToBellNotice = PublishRelay<Void>()
        let goToWriting = PublishRelay<Void>()
        let goToDetail = PublishRelay<Article>()
        let currentStyle = BehaviorRelay<MyWritingStyle>(value: .myWriting)

        let myWritingList = BehaviorRelay<[FeedSection]>(value: [])
        let tempWritingList = BehaviorRelay<[FeedSection]>(value: [])

        let tagList = Observable<[String]>.of(["전체"] + StringType.myWritingTags)

        let showError = PublishRelay<Error>()
        let myWritingCursor = BehaviorRelay<String>(value: "")
        let tempWritingCursor = BehaviorRelay<String>(value: "")
        let nowTag = BehaviorRelay<String>(value: "")

    }

    var input: Input
    var output: Output

    var disposeBag = DisposeBag()
    var myWritingService = MyWritingService()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bind()
    }

}

extension MyWritingViewModel {

    func bindMyWritingList(cursor: String?, tag: String?, pagination: Bool) {

        guard !myWritingService.isMyWritingPaginating else {
            return
        }

        myWritingService.getMyArticle(cursor: cursor, type: tag == "" ? nil : tag, pagination: pagination)
            .withUnretained(self)
            .subscribe(onNext: { owner, articleResponse in
                owner.output.myWritingCursor.accept(articleResponse.next_cursor ?? "")

                let oldList = owner.output.myWritingList.value

                var oldArticles: [Article] = []
                if pagination && !oldList.isEmpty {
                    oldArticles = oldList[0].items
                }

                owner.output.myWritingList.accept(
                    [FeedSection(
                        header: Relay(),
                        items: oldArticles + (articleResponse.articles ?? [])
                    )]
                )
            }, onError: {[weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }

    func bindTempWritingList(cursor: String?, pagination: Bool) {

        guard !myWritingService.isTempWritingPaginating else {
            return
        }

        myWritingService.getMyArticleTemp(cursor: cursor, pagination: pagination)
            .withUnretained(self)
            .subscribe(onNext: { owner, articleResponse in
                owner.output.tempWritingCursor.accept(articleResponse.next_cursor ?? "")

                let oldList = owner.output.tempWritingList.value

                var oldArticles: [Article] = []
                if pagination && !oldList.isEmpty {
                    oldArticles = oldList[0].items
                }

                owner.output.tempWritingList.accept(
                    [FeedSection(
                        header: Relay(),
                        items: oldArticles + (articleResponse.articles ?? [])
                    )]
                )
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }

    func bind() {
        input.myWritingCellTap
            .withUnretained(self)
            .bind { owner, article in
                print("TAPPED!")
                owner.output.goToDetail.accept(article)
            }
            .disposed(by: disposeBag)

        input.addWritingButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToWriting.accept(())
            }
            .disposed(by: disposeBag)

        input.tagTap
            .withUnretained(self)
            .bind { owner, tagString in

                var type: String = ""
                if tagString == "챌린지" {
                    type = "challenge"
                } else if tagString == "릴레이" {
                    type = "relay"
                } else if tagString == "자유" {
                    type = "free"
                }

                print("TAGSTRING: \(tagString)")

                owner.output.nowTag.accept(type)
                owner.bindMyWritingList(cursor: nil, tag: type, pagination: false)
            }
            .disposed(by: disposeBag)

        input.myWritingTap
            .withUnretained(self)
            .bind {owner, _ in
                owner.output.currentStyle.accept(.myWriting)
            }
            .disposed(by: disposeBag)

        input.tempWritingTap
            .withUnretained(self)
            .bind {owner, _ in
                owner.output.currentStyle.accept(.tempWriting)
            }
            .disposed(by: disposeBag)
    }
}

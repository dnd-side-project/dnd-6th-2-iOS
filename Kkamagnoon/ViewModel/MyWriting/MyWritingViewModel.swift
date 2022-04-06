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
        let changeToMyWritingList = PublishRelay<Void>()
        let changeToTempWritingList = PublishRelay<Void>()

        let myWritingList = PublishRelay<[FeedSection]>()
        let tempWritingList = PublishRelay<[FeedSection]>()
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

    func bindMyWritingList(tag: String?) {
        myWritingService.getMyArticle(cursor: nil, type: tag)
            .withUnretained(self)
            .bind { owner, articleResponse in
                owner.output.myWritingList.accept(
                    [FeedSection(header: Relay(), items: articleResponse.articles ?? [])]
                )
            }
            .disposed(by: disposeBag)
    }

    func bindTempWritingList() {
        myWritingService.getMyArticleTemp(cursor: nil)
            .withUnretained(self)
            .bind { owner, articleResponse in
                owner.output.tempWritingList.accept(
                    [FeedSection(header: Relay(), items: articleResponse.articles ?? [])]
                )
            }
            .disposed(by: disposeBag)
    }

    func bind() {
        input.myWritingCellTap
            .withUnretained(self)
            .bind { owner, article in
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

                owner.bindMyWritingList(tag: type)
            }
            .disposed(by: disposeBag)

        input.myWritingTap
            .withUnretained(self)
            .bind {owner, _ in
                owner.output.changeToMyWritingList.accept(())
            }
            .disposed(by: disposeBag)

        input.tempWritingTap
            .withUnretained(self)
            .bind {owner, _ in
                owner.output.changeToTempWritingList.accept(())
            }
            .disposed(by: disposeBag)
    }
}

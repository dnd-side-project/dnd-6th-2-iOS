//
//  DetailContentViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa

class DetailContentViewModel: ViewModelType {

    var article: Article?

    struct Input {
        let backButtonTap = PublishSubject<Void>()
        let subscribeButtonTap = PublishSubject<Void>()
        let moreButtonTap = PublishSubject<Void>()
        let likeButtonTap = PublishSubject<Void>()
        let commentButtonTap = PublishSubject<Void>()
        let scrapButtonTap = PublishSubject<Void>()
    }

    struct Output {

        // TODO: 구독하기 버튼 클릭시

        let popBack = PublishRelay<Void>()
        let goToReport = PublishRelay<Void>()
        let like = BehaviorRelay<Int>(value: 0)
        let goToCommentPage = PublishRelay<Void>()
        let scrap = BehaviorRelay<Int>(value: 0)
    }

    var input: Input
    var output: Output

    var feedService: FeedService
    var subscribeService: FeedSubscribeService

    var disposeBag = DisposeBag()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        self.feedService = FeedService()
        self.subscribeService = FeedSubscribeService()

        bind()
    }

    func bind() {
        input.backButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.popBack.accept(())
            }
            .disposed(by: disposeBag)

        input.subscribeButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                guard let article = owner.article, let user = article.user, let id = user._id
                else { return }
                owner.subscribeService.patchSubscribe(authorId: id)
            }
            .disposed(by: disposeBag)

        input.moreButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToReport.accept(())
            }
            .disposed(by: disposeBag)

        input.likeButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                guard let article = owner.article else {
                    return
                }

                owner.feedService.postLike(articleId: article._id ?? "", like: ScrapDTO())
                    // .bind to output
            }
            .disposed(by: disposeBag)

        input.commentButtonTap
            .withUnretained(self)
            .bind {owner, _ in
                owner.output.goToCommentPage.accept(())
            }
            .disposed(by: disposeBag)

        input.scrapButtonTap
            .withUnretained(self)
            .bind {owner, _ in
                guard let article = owner.article else {
                    return
                }

                owner.feedService.postScrap(articleId: article._id ?? "", scrap: ScrapDTO())
            }
        // map
            .disposed(by: disposeBag)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

//
//  DetailContentViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa
import Differentiator

class DetailContentViewModel: ViewModelType {

    struct Input {
        let articleId = BehaviorRelay<String>(value: "")
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
        let article = BehaviorRelay<Article>(value: Article())
        let tags = BehaviorRelay<[SectionModel<String, String>]>(value: [])
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

    func bindArticle() {
        print("!!!!! >> \(input.articleId.value)")
        feedService.getArticle(articleId: input.articleId.value)
            .withUnretained(self)
            .bind { owner, article in
                owner.output.article.accept(article)
                owner.output.tags.accept([SectionModel(model: "", items: article.tags ?? [])])
            }
            .disposed(by: disposeBag)
    }

    func bind() {
        input.backButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.popBack.accept(())
            }
            .disposed(by: disposeBag)

        input.subscribeButtonTap
            .bind(onNext: patchSubscribeService)
            .disposed(by: disposeBag)

        input.moreButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToReport.accept(())
            }
            .disposed(by: disposeBag)

        input.likeButtonTap
            .bind(onNext: postLikeService)
            .disposed(by: disposeBag)

        input.commentButtonTap
            .withUnretained(self)
            .bind {owner, _ in
                owner.output.goToCommentPage.accept(())
            }
            .disposed(by: disposeBag)

        input.scrapButtonTap
            .bind(onNext: postScrapService)
            .disposed(by: disposeBag)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension DetailContentViewModel {

    private func patchSubscribeService() {
        let id = output.article.value.user?._id
        subscribeService.patchSubscribe(authorId: id ?? "")
            .bind { message in
                print(message.message ?? "")
            }
            .disposed(by: disposeBag)
    }

    private func postLikeService() {
        feedService.postLike(articleId: input.articleId.value, like: ScrapDTO(category: "string"))
            .withUnretained(self)
            .bind { owner, like in
                owner.output.like.accept(like.article?.likeNum ?? 0)
            }
            .disposed(by: disposeBag)
    }

    private func postScrapService() {
        feedService.postScrap(articleId: input.articleId.value, scrap: ScrapDTO(category: "string"))
            .withUnretained(self)
            .bind { owner, scrap in
                owner.output.scrap.accept(scrap.article?.scrapNum ?? 0)
            }
            .disposed(by: disposeBag)
    }
}

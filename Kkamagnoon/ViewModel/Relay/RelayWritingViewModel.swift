//
//  RelayWritingViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/09.
//

import UIKit
import RxSwift
import RxCocoa

class RelayWritingViewModel: ViewModelType {

    var relayArticleDTO = RelayArticleDTO()
    var relayInfo: Relay?
    var articleList: [Article]?
    var rootView: UIViewController?

    struct Input {
        let contents = PublishSubject<String>()

        let copyButtonTap = PublishSubject<Void>()
        let alignButtonTap = PublishSubject<Void>()
        let completeButtonTap = PublishSubject<Void>()
    }

    struct Output {

        let showError = PublishRelay<Error>()

//        let article = PublishRelay<CreateArticleDTO>()
        let enableCompleteButton = PublishRelay<Bool>()
        let registerWriting = PublishRelay<Article>()
        let tips = PublishRelay<String>()

    }

    var input: Input
    var output: Output

    var disposeBag = DisposeBag()
    var challengeService = ChallengeService()
    var relayArticleService = RelayArticleService()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bind()
    }
}

extension RelayWritingViewModel {
    func bindTips() {
        challengeService.getChallengeArticle()
            .withUnretained(self)
            .bind { owner, tip in

                owner.output.tips.accept(tip.content ?? "글쓰기를 위한 팁")
            }
            .disposed(by: disposeBag)
    }

    func bind() {
        input.contents
            .withUnretained(self)
            .bind { owner, content in
                if !content.isEmpty {
                    owner.relayArticleDTO.content = content
                    owner.output.enableCompleteButton.accept(true)
                } else {
                    owner.output.enableCompleteButton.accept(false)
                }
            }
            .disposed(by: disposeBag)

        input.completeButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.postRelayArticle()
            }
            .disposed(by: disposeBag)

    }

    private func postRelayArticle() {
        relayArticleService.postRelayArticle(
            relayId: relayInfo?._id ?? "",
            relayArticle: relayArticleDTO)
        .withUnretained(self)
        .subscribe(onNext: { owner, article in
            owner.output.registerWriting.accept(article)
        }, onError: { [weak self] error in
            self?.output.showError.accept(error)
        })
        .disposed(by: disposeBag)
    }
}

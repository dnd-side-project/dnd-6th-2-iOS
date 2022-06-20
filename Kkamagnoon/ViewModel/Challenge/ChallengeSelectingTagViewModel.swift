//
//  ChallengeSelectingTagViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class ChallengeSelectingTagViewModel: ViewModelType {
    var checkSelectedTags = [String: Bool]()
    var rootView: UIViewController?

    var articleDTO: CreateArticleDTO?

    struct Input {
        let backButtonTap = PublishSubject<Void>()
        let tagTap = PublishSubject<String>()
        let tempSaveButtonTap = PublishSubject<Void>()
        let completeButtonTap = PublishSubject<Void>()
    }

    struct Output {
//        let tagList = PublishRelay<[String]>()
        let showError = PublishRelay<Error>()
        let goToMainView = PublishRelay<Bool>()
        let goToMainViewAndPopUp = PublishRelay<Bool>()
    }
    var input: Input
    var output: Output

    var disposeBag = DisposeBag()
    var challengeService = ChallengeService()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        StringType.categories.forEach({ tag in
            checkSelectedTags.updateValue(false, forKey: tag)
        })

        bind()

    }
}

extension ChallengeSelectingTagViewModel {
    func bind() {
        input.backButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToMainView.accept(false)
            }
            .disposed(by: disposeBag)

        input.tagTap
            .withUnretained(self)
            .bind { owner, model in

                let checked = owner.checkSelectedTags[model] ?? false
                owner.checkSelectedTags.updateValue(!checked, forKey: model)

                var tagArray: [String] = []
                owner.checkSelectedTags.forEach({ tag in
                    if tag.value {
                        tagArray.append(tag.key)
                    }
                })
                owner.articleDTO?.tags = tagArray

            }
            .disposed(by: disposeBag)

        input.tempSaveButtonTap
            .withUnretained(self)
            .bind { owner, _ in

                owner.challengeService.postChallengeArticle(article: owner.articleDTO ?? CreateArticleDTO())
                    .bind { article in
                        owner.output.goToMainViewAndPopUp.accept(article.state ?? false)
                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)

        input.completeButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.postChallengeArticle()
            }
            .disposed(by: disposeBag)
    }

    private func postChallengeArticle() {
        challengeService.postChallengeArticle(article: articleDTO ?? CreateArticleDTO())
            .withUnretained(self)
            .subscribe(onNext: { owner, article in
                owner.output.goToMainViewAndPopUp.accept(article.state ?? false)
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }
}

//
//  WritingViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class WritingViewModel: ViewModelType {

    var articleDTO = CreateArticleDTO()
    var rootView: UIViewController?

    struct Input {
        let title = PublishSubject<String>()
        let contents = PublishSubject<String>()

        let copyButtonTap = PublishSubject<Void>()
        let alignButtonTap = PublishSubject<Void>()
        let completeButtonTap = PublishSubject<Void>()
    }

    struct Output {
//        let article = PublishRelay<CreateArticleDTO>()
        let enableCompleteButton = PublishRelay<Bool>()
        let tips = PublishRelay<String>()

        let goToSelection = PublishRelay<CreateArticleDTO>()
    }

    var input: Input
    var output: Output

    var disposeBag = DisposeBag()
    var challengeService = ChallengeService()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bind()

        // TEMP
        articleDTO.public = false
    }
}

extension WritingViewModel {
    func bindTips() {
        challengeService.getChallengeArticle()
            .withUnretained(self)
            .bind { owner, tip in

                owner.output.tips.accept(tip.content ?? "글쓰기를 위한 팁")
            }
            .disposed(by: disposeBag)
    }

    func bind() {
        Observable.combineLatest(input.title, input.contents)
            .map {[weak self] title, contents in
                if !(title.isEmpty) &&
                    contents != StringType.contentPlaceholder {
                    self?.articleDTO.title = title
                    self?.articleDTO.content = contents

                    return true
                }
                return false
            }
            .bind(to: output.enableCompleteButton)
            .disposed(by: disposeBag)

        input.completeButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToSelection.accept(owner.articleDTO)
            }
            .disposed(by: disposeBag)
    }
}

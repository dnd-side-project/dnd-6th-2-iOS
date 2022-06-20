//
//  DetailMyWritingViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/27.
//

import RxSwift
import RxCocoa

class DetailMyWritingViewModel: ViewModelType {

    struct Input {
        let articleId = BehaviorRelay<String>(value: "")
    }

    struct Output {
        let showError = PublishRelay<Error>()
        let article = BehaviorRelay<Article>(value: Article())
    }

    var input: Input
    var output: Output
    let myWritingService = MyWritingService()
    var disposeBag = DisposeBag()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

    }

    func bindArticle() {
        myWritingService
            .getMyArticleDetail(articleId: input.articleId.value)
            .withUnretained(self)
            .subscribe(onNext: { owner, myWriting in
                owner.output.article.accept(myWriting.article ?? Article())
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }
}

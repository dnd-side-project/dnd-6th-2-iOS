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
        let article = PublishRelay<Article>()
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
            .bind { owner, myWriting in
                owner.output.article.accept(myWriting.article ?? Article())
            }
            .disposed(by: disposeBag)
    }
}

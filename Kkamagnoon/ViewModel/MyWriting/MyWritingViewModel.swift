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
        let tagTap = PublishSubject<String>()
        let addWritingButtonTap = PublishSubject<Void>()
        let myWritingCellTap = PublishSubject<Article>()

    }

    struct Output {
        let goToBellNotice = PublishRelay<Void>()
        let goToWriting = PublishRelay<Void>()
        let goToDetail = PublishRelay<Article>()

        let articleList = PublishRelay<[FeedSection]>()
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

    func bindMyWritingList() {
        myWritingService.getMyArticle(cursor: nil, type: nil)
            .withUnretained(self)
            .bind { owner, articleResponse in
                owner.output.articleList.accept(
                    [FeedSection(header: Relay(), items: articleResponse.articles ?? [])]
                )
            }
            .disposed(by: disposeBag)
    }

    func bind() {
        input.myWritingCellTap
            .withUnretained(self)
            .bind { owner, article in
                print("TPAPP!!")
                owner.output.goToDetail.accept(article)
            }
            .disposed(by: disposeBag)

        input.addWritingButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToWriting.accept(())
            }
            .disposed(by: disposeBag)
    }
}

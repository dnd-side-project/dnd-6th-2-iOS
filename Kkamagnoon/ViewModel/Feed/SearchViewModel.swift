//
//  SearchViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewModel: ViewModelType {

    var commentList: [Comment]?

    struct Input {
        let backButtonTap = PublishSubject<Void>()
        let searchWord = BehaviorRelay<String>(value: "")
        let searchButtonTap = PublishSubject<Void>()
    }

    struct Output {
        let dismissView = PublishRelay<Void>()
        let recentSearchList = BehaviorRelay<[SectionModel<String, History>]>(value: [])
    }

    var input: Input
    var output: Output

    var disposeBag = DisposeBag()
    var feedSearchService = FeedSearchService()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        bind()
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension SearchViewModel {

    func getRecentSearchList() {
        feedSearchService.getSearchFeedHistory()
            .withUnretained(self)
            .bind { owner, list in
                owner.output.recentSearchList.accept([SectionModel(model: "", items: list)])
            }
            .disposed(by: disposeBag)
    }

    func bind() {
        input.backButtonTap.bind(to: output.dismissView)
            .disposed(by: disposeBag)

        input.searchButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                let searchWord = owner.input.searchWord.value
                owner.feedSearchService.getSearchFeed(cursor: nil, content: searchWord, type: nil, orderBy: "최신순")
                    .bind { _ in

                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)

    }

}

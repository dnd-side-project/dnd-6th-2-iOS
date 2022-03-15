//
//  SearchViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {

    var commentList: [Comment]?

    struct Input {
//        let backViewTap = PublishSubject<Void>()
//        let moreButtonTap = PublishSubject<Void>()
//        let sendButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let dismissView = PublishRelay<Void>()
        let recentSearchList = BehaviorRelay<[String]>(value: [])
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
//        feedSearchService.getSearchFeedHistory()
    }

    func bind() {
    }

}

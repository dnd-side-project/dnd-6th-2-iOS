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

    struct Input {
        let backButtonTap = PublishSubject<Void>()
        let searchWord = BehaviorRelay<String>(value: "")
        let searchButtonTap = PublishSubject<Void>()
        let historyWordTap = PublishSubject<History>()
        let menuTapAtIndex = PublishSubject<IndexPath>()
    }

    struct Output {
        let menuList = Observable.of(["챌린지", "자유글", "릴레이"])
        let dismissView = PublishRelay<Void>()
        let recentSearchList = BehaviorRelay<[SectionModel<String, History>]>(value: [])
        let searchResultList = BehaviorRelay<[SectionModel<String, Article>]>(value: [])
        let searchContentStyle = BehaviorRelay<SearchContentStyle>(value: .history)
//        let searchWord = BehaviorRelay<String>(value: "")
        let moveIndicatorBar = PublishRelay<IndexPath>()
        let searchType = BehaviorRelay<String>(value: "challenge")
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
                owner.searchBy(word: owner.input.searchWord.value, type: owner.output.searchType.value)
            }
            .disposed(by: disposeBag)

        input.historyWordTap
            .withUnretained(self)
            .bind { owner, history in
                owner.input.searchWord.accept(history.content ?? "")
                owner.searchBy(word: history.content ?? "", type: owner.output.searchType.value)
            }
            .disposed(by: disposeBag)

        input.menuTapAtIndex
            .withUnretained(self)
            .bind { owner, indexPath in
                owner.output.moveIndicatorBar.accept(indexPath)
                owner.output.searchType.accept(owner.indexPathToType(indexPath: indexPath))
            }
            .disposed(by: disposeBag)

        output.searchType
            .skip(1)
            .withUnretained(self)
            .bind { owner, searchType in
                owner.searchBy(word: owner.input.searchWord.value, type: searchType)
            }
            .disposed(by: disposeBag)
    }

    private func indexPathToType(indexPath: IndexPath) -> String {
        if indexPath.row == 0 {
            return "challenge"
        } else if indexPath.row == 1 {
            return "free"
        } else {
            return "relay"
        }
    }

    private func searchBy(word: String, type: String) {
        feedSearchService.getSearchFeed(cursor: nil, content: word, type: type, orderBy: "최신순")
            .withUnretained(self)
            .bind { owner, result in
                owner.output.searchResultList.accept([SectionModel(model: "", items: result.articles ?? [])])
//                owner.output.searchWord.accept(word)
                owner.output.searchContentStyle.accept(.searchResult)
            }
            .disposed(by: disposeBag)
    }

}

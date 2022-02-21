//
//  FeedViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//
import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class FeedViewModel: ViewModelType {

    struct Input {
        let wholeFeedButtonTap = PublishSubject<Void>()
        let subscribedFeedButtonTap = PublishSubject<Void>()
        let searchButtonTap = PublishSubject<Void>()
        let bellButtonTap = PublishSubject<Void>()

        let tagCellTap = PublishSubject<Void>()
        let subscribeCellTap = PublishSubject<Void>()

        let sortButtonTap = PublishSubject<Void>()
        // Temp
        let feedCellTap = PublishSubject<IndexPath>()
        let moreButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let currentFeedStyle = BehaviorRelay<FeedStyle>(value: .whole)
        let goToSearch = PublishRelay<Void>()
        let goToBell = PublishRelay<Void>()
        let currentSortStyle = BehaviorRelay<SortStyle>(value: .byLatest)
        let goToDetailFeed = PublishRelay<IndexPath>()

        let tagList = BehaviorRelay<[String]>(value: [])

        // TEMP String -> FeedInfo
        let wholeFeedList = BehaviorRelay<[SectionModel<String, String>]>(value: [])

        let subscribeFeedList = BehaviorRelay<[String]>(value: [])
    }

    var input: Input
    var output: Output
    var feedService: FeedService!
    var subscribeService: FeedSubscribeService!

    var disposeBag = DisposeBag()
    var sortStyle: SortStyle = .byPopularity

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        self.feedService = FeedService()

        bind()
        bindWholeFeedList()
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension FeedViewModel {

    func bindWholeFeedList() {

        // TODO: 정렬 순서대로 요청
//        feedService.getWholeFeed(next_cursor: , orderBy: sortStyle)

        // TEMP
        Observable.just([SectionModel(model: "최신순", items: ["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])])
            .bind { [weak self] list in
                guard let self = self else {return}
                self.output.wholeFeedList.accept(list)
            }
            .disposed(by: disposeBag)
    }

    func bindSubscribedFeedList() {
        // TODO: 구독 피드 요청
//        subscribeService.getSubscribeFeed(cursor: <#T##String?#>)
    }

    func bind() {
        input.wholeFeedButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.currentFeedStyle.accept(.whole)
            }
            .disposed(by: disposeBag)

        input.subscribedFeedButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.currentFeedStyle.accept(.subscribed)
            }
            .disposed(by: disposeBag)

        input.searchButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToSearch.accept(())
            }
            .disposed(by: disposeBag)

        input.bellButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToBell.accept(())
            }
            .disposed(by: disposeBag)

        input.tagCellTap
            .withUnretained(self)
            .bind { owner, _ in
                // TODO: 태그별로 검색
                var tags: [String] = owner.output.tagList.value
//                tags.append(contentsOf: tagString)

//                feedService.getWholeFeed(next_cursor: <#T##String?#>, orderBy: <#T##String#>, tags: [])
            }
            .disposed(by: disposeBag)

        input.sortButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                if owner.sortStyle == .byLatest {
                    owner.output.currentSortStyle.accept(.byPopularity)
                    owner.sortStyle = .byPopularity
                } else {
                    owner.output.currentSortStyle.accept(.byLatest)
                    owner.sortStyle = .byLatest
                }
            }
            .disposed(by: disposeBag)

        input.feedCellTap
            .bind { [weak self] indexPath in
                guard let self = self else {return}
                self.output.goToDetailFeed.accept(indexPath)
            }
            .disposed(by: disposeBag)
    }

}

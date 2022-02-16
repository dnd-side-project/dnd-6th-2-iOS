//
//  FeedViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//

import Foundation
import RxSwift
import RxCocoa

protocol FeedViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}

class FeedViewModel: FeedViewModelType {

    struct Input {
        let wholeFeedButtonTap = PublishSubject<Void>()
        let subscribedFeedButtonTap = PublishSubject<Void>()
        let searchButtonTap = PublishSubject<Void>()
        let bellButtonTap = PublishSubject<Void>()
        let tagCellTap = PublishSubject<Void>()
        let sortButtonTap = PublishSubject<Void>()
        // Temp
        let feedCellTap = PublishSubject<String>()
        let moreButtonTap = PublishSubject<Void>()

        // add more...

    }

    struct Output {
        let currentFeedStyle = BehaviorRelay<FeedStyle>(value: .whole)
        let goToSearch = PublishRelay<Void>()
        let goToBell = PublishRelay<Void>()
        let currentSortStyle = BehaviorRelay<SortStyle>(value: .byLatest)
        let goToDetailFeed = PublishRelay<String>()

        // TEMP String -> FeedInfo
        let wholeFeedListRelay = BehaviorRelay<[String]>(value: [])
        let subscribeFeedListRelay = BehaviorRelay<[String]>(value: [])
    }

    var input: Input
    var output: Output
    var service: FeedService!

    var disposeBag = DisposeBag()
    private var sortStyle: SortStyle = .byLatest

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        self.service = FeedService()

        bindChangeFeed()
        bindExtraButton()
        bindSortButton()
        bindWholeFeedList()
        bindSubscribedFeedList()
    }

    func bindChangeFeed() {
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
    }

    func bindExtraButton() {
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
    }

    func bindSortButton() {
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
    }

    func bindWholeFeedList() {
        // DUMMY
        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])
        dummyData.bind { [weak self] list in
            guard let self = self else {return}
            self.output.wholeFeedListRelay.accept(list)
        }
        .disposed(by: disposeBag)

        input.feedCellTap
            .bind { [weak self] temp in
                guard let self = self else {return}
                self.output.goToDetailFeed.accept(temp)
            }
            .disposed(by: disposeBag)
    }

    func bindSubscribedFeedList() {
        // DUMMY
        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "긴 글", "무서운 글", "한글", "세종대왕"])
        dummyData.bind { [weak self] list in
            guard let self = self else {return}
            self.output.subscribeFeedListRelay.accept(list)
        }
        .disposed(by: disposeBag)
    }

//    func getWholeFeedList() {
//        let endPoint = FeedEndpointCases.getWholeFeed(page: 1)
//        service.getWholeFeed(page: 1)
//            .bind(to: output.wholeFeedListRelay)
//            .disposed(by: disposeBag)
//    }

//    func getSubscribeFeedList() {
//        service.getWholeFeed()
//            .bind(to: output.wholeFeedListRelay)
//            .disposed(by: disposeBag)
//    }

    deinit {
        disposeBag = DisposeBag()
    }
}

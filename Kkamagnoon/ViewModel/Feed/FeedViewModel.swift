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

        let tagCellTap = PublishSubject<String>()
        let subscribeCellTap = PublishSubject<Void>()

        let feedCellTap = PublishSubject<Article>()
        let moreButtonTap = PublishSubject<Void>()
        let allSubscriberButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let goToSearch = PublishRelay<Void>()
        let goToBell = PublishRelay<Void>()
        let goToDetailFeed = PublishRelay<Article>()
        let goToAllSubscriberList = PublishRelay<[Host]>()
        
        let showError = PublishRelay<Error>()

        let wholeFeedList = BehaviorRelay<[FeedSection]>(value: [])
        let tagList = Observable<[String]>.of(StringType.categories)
        let subscribeFeedList = BehaviorRelay<[String]>(value: [])
        let sortStyle = BehaviorRelay<SortStyle>(value: .byLatest)
    }

    let input: Input
    let output: Output
    let feedService: FeedService!
    var feedSubscribeService: FeedSubscribeService!

    var disposeBag = DisposeBag()

    var checkSelectedTags = [String: Bool]()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        self.feedService = FeedService()
        self.feedSubscribeService = FeedSubscribeService()

        StringType.categories.forEach({ tag in
            checkSelectedTags.updateValue(false, forKey: tag)
        })

        bindWork()
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension FeedViewModel {

    func bindWork() {
//        input.wholeFeedButtonTap
//            .withUnretained(self)
//            .bind { owner, _ in
//                owner.output.currentFeedStyle.accept(.whole)
//            }
//            .disposed(by: disposeBag)
//
//        input.subscribedFeedButtonTap
//            .withUnretained(self)
//            .bind { owner, _ in
//                owner.output.currentFeedStyle.accept(.subscribed)
//            }
//            .disposed(by: disposeBag)

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
            .bind(onNext: updateTagList)
            .disposed(by: disposeBag)

        input.feedCellTap
            .withUnretained(self)
            .bind { owner, article in
                 owner.output.goToDetailFeed.accept(article)
            }
            .disposed(by: disposeBag)

        input.allSubscriberButtonTap
            .bind(onNext: fetchAuthorList)
            .disposed(by: disposeBag)
    }

}

extension FeedViewModel {
    func bindWholeFeedList() {

        feedService.getWholeFeed(next_cursor: nil, orderBy: output.sortStyle.value.rawValue, tags: checkSelectedTags)
            .withUnretained(self)
            .subscribe (onNext: { owner, articleResponse in
                owner.output.wholeFeedList.accept(
                    [FeedSection(header: Relay(), items: articleResponse.articles ?? [])]
                )
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }

    func bindSubscribedFeedList() {
        // TODO: 구독 피드 요청

    }

    private func fetchAuthorList() {
        feedSubscribeService.getSubscribeAuthorList()
            .withUnretained(self)
            .subscribe(onNext: { owner, authorList in
                owner.output.goToAllSubscriberList.accept(authorList)
            }, onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }

    private func updateTagList(tagString: String) {
        let nowValue = checkSelectedTags[tagString, default: false]

        checkSelectedTags.updateValue(!nowValue, forKey: tagString)
        bindWholeFeedList()
    }
}

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

    }

    struct Output {
        let wholeFeedListRelay = BehaviorRelay<[FeedInfo]>(value: [])
        let subscribeFeedListRelay = BehaviorRelay<[FeedInfo]>(value: [])
    }

    var input: Input
    var output: Output
     var service: FeedService!

    var disposeBag = DisposeBag()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        self.service = FeedService()
    }

    func getWholeFeedList() {
//        let endPoint = FeedEndpointCases.getWholeFeed(page: 1)
        service.getWholeFeed(page: 1)
//            .bind(to: output.wholeFeedListRelay)
//            .disposed(by: disposeBag)
    }

//    func getSubscribeFeedList() {
//        service.getWholeFeed()
//            .bind(to: output.wholeFeedListRelay)
//            .disposed(by: disposeBag)
//    }

    deinit {
        disposeBag = DisposeBag()
    }
 }

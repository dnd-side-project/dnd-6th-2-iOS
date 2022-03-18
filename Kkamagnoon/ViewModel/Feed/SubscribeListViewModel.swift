//
//  SubscribeListViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import RxSwift
import RxCocoa

class SubscribeListViewModel: ViewModelType {

    struct Input {
        let backButtonTap = PublishSubject<Void>()
        let subscribeButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let popBack = PublishRelay<Void>()
        let subscribe = BehaviorRelay<SubscribeStyle>(value: .notSubscribing)

        let subscribingList = BehaviorRelay<[User]>(value: [])
    }

    var input: Input
    var output: Output

    var subscribeService: FeedSubscribeService

    var disposeBag = DisposeBag()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        self.subscribeService = FeedSubscribeService()

        bind()
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension SubscribeListViewModel {
    func bind() {
        input.backButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.popBack.accept(())
            }
            .disposed(by: disposeBag)

        input.subscribeButtonTap
            .withUnretained(self)
            .bind { _, _ in
                // TODO: SUBSCRIBE USER!!
//                owner.subscribeService.patchSubscribe(authorId: <#T##String#>)
            }
            .disposed(by: disposeBag)
    }

    func loadSubscribingList() {
        subscribeService.getSubscribeAuthorList()
        // TODO: bind to subscribe list
    }
}

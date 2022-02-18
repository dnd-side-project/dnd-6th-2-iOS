//
//  SelectTagViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxSwift
import RxCocoa

class SelectTagViewModel: ViewModelType {
    var disposeBag = DisposeBag()

    struct Input {
        let tagTap = PublishSubject<IndexPath>()
        let completeButtonTap = PublishSubject<Void>()
        // add more...
    }

    struct Output {
        let tagList = BehaviorRelay<[String]>(value: [])
        let goBackToMakingView = PublishRelay<Void>()
    }

    var input: Input
    var output: Output

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bindComplete()
    }

    func bindComplete() {
        input.completeButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goBackToMakingView.accept(())
            }
            .disposed(by: disposeBag)
    }
}

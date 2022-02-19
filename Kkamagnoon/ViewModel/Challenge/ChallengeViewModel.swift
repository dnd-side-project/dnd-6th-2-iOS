//
//  ChallengeViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/19.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class ChallengeViewModel: ViewModelType {

    struct Input {
        let addWritingButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let goToWriting = PublishRelay<Void>()
    }

    var input: Input
    var output: Output

    var disposeBag = DisposeBag()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        bindAddWritingButton()

    }

    func bindAddWritingButton() {
        input.addWritingButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToWriting.accept(())
            }
            .disposed(by: disposeBag)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

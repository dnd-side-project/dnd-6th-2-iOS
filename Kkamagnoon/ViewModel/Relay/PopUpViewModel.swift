//
//  PopUpViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxSwift
import RxCocoa

class PopUpViewModel: ViewModelType {

    var disposeBag = DisposeBag()

    struct Input {
        let exitButtonTap = PublishSubject<Void>()
        let enterButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let relayDetailViewStyle = BehaviorRelay<RelayRoomState>(value: .nonParticipation)

    }

    var input: Input
    var output: Output

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bindButton()
    }

    func bindButton() {
        input.exitButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.relayDetailViewStyle.accept(.nonParticipation)
            }
            .disposed(by: disposeBag)

        input.enterButtonTap
            .withUnretained(self)
            .bind {owner, _ in
                owner.output.relayDetailViewStyle.accept(.participation)
            }
            .disposed(by: disposeBag)
    }
}

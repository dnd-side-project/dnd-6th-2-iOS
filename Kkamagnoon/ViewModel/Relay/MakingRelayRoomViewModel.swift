//
//  MakingRelayRoomViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxSwift
import RxCocoa

class MakingRelayRoomModel: ViewModelType {
    var disposeBag = DisposeBag()
    var rootView: UIViewController?

    struct Input {
        let tags = PublishSubject<[String]>()

        let title = PublishSubject<String>()
        let notice = PublishSubject<String>()

        let plusButtonTap = PublishSubject<Void>()
        let minusButtonTap = PublishSubject<Void>()

        let startButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let enableStartButton = PublishRelay<Bool>()
        let goToNewRelay = PublishRelay<Void>()

        let personnelCount = BehaviorRelay<Int>(value: 0)
    }

    var input: Input
    var output: Output

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bindStartButtonEnable()
        bindStartButtonTap()
    }

    func bindStartButtonEnable() {
        Observable.combineLatest(input.title, input.notice)
            .map { title, notice in
                if title == StringType.titlePlaceeholder ||
                    notice == StringType.noticePlaceholder {
                    return false
                }
                return true
            }
            .bind(to: output.enableStartButton)
            .disposed(by: disposeBag)

    }

    func bindStartButtonTap() {
        input.startButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToNewRelay.accept(())
            }
            .disposed(by: disposeBag)
    }

    func bindPersonnel() {
        input.minusButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                print(">>> TAP")
                if owner.output.personnelCount.value > 0 {
                    owner.output.personnelCount.accept(owner.output.personnelCount.value-1)
                }
            }
            .disposed(by: disposeBag)

        input.plusButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                if owner.output.personnelCount.value < 10 {
                    owner.output.personnelCount.accept(owner.output.personnelCount.value+1)
                }
            }
            .disposed(by: disposeBag)
    }

}

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
        let bellButtonTap = PublishSubject<Void>()
        let addWritingButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let goToBellNotice = PublishRelay<Void>()
        let goToWriting = PublishRelay<Void>()

        let keyWord = PublishRelay<Keyword>()
    }

    var input: Input
    var output: Output

    var disposeBag = DisposeBag()
    var challengeService = ChallengeService()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bindBellButton()
        bindAddWritingButton()

    }

    func bindKeyword() {
        challengeService.getChallenge()
            .withUnretained(self)
            .bind { owner, challengeMain in
                owner.output.keyWord.accept(challengeMain.keyword ?? Keyword())
            }
            .disposed(by: disposeBag)
    }

    func bindBellButton() {
        input.bellButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToBellNotice.accept(())
            }
            .disposed(by: disposeBag)
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

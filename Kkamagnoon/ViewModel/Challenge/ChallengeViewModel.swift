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
        let cardTap = PublishSubject<UITapGestureRecognizer>()
        let expansionButtonTap = PublishSubject<Void>()
        let goToFeedButtonTap = PublishSubject<Void>()
    }

    struct Output {
        let showError = PublishRelay<Error>()
        let goToBellNotice = PublishRelay<Void>()
        let goToWriting = PublishRelay<Void>()
//        let goToDetail = PublishRelay<Void>()
//        let challenge = BehaviorRelay<GetChallengeMain>(value: GetChallengeMain())
        let challenge = PublishSubject<GetChallengeMain>()
        let calendarState = BehaviorRelay<CalendarState>(value: .week)
        let challangeStamp = BehaviorRelay<GetMonthlyDTO>(value: GetMonthlyDTO())
        let goToFeed = PublishRelay<Void>()
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
//        bindCard()
        bindWork()
    }

    func bindKeyword() {
        challengeService.getChallenge()
            .withUnretained(self)
            .subscribe(onNext: { owner, challengeMain in
//                owner.output.challenge.accept(challengeMain)
                owner.output.challenge.onNext(challengeMain)
            },
                        onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }

    func bindChallengeStamp(month: String, year: String) {
        challengeService.getChallengeStamp(month: month, year: year)
            .withUnretained(self)
            .bind { owner, challengeStamp in
                owner.output.challangeStamp.accept(challengeStamp)
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

//    func bindCard() {
//        input.cardTap
//            .withUnretained(self)
//            .bind { owner, _ in
//                print("TAPPED!!")
//                owner.output.goToDetail.accept(())
//            }
//            .disposed(by: disposeBag)
//    }

    func bindWork() {
        input.expansionButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                if owner.output.calendarState.value == .week {
                    owner.output.calendarState.accept(.month)
                } else {
                    owner.output.calendarState.accept(.week)
                }
            }
            .disposed(by: disposeBag)

        input.goToFeedButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToFeed.accept(())
            }
            .disposed(by: disposeBag)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

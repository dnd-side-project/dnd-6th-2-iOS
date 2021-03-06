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
        let selectMonthButtonTap = PublishSubject<Void>()
    }

    struct Output {
        let challenge = PublishSubject<GetChallengeMain>()
        let challangeStamp = PublishSubject<GetMonthlyDTO>()

        let showError = PublishRelay<Error>()
        let calendarState = BehaviorRelay<CalendarState>(value: .week)

        let goToBellNotice = PublishRelay<Void>()
        let goToWriting = PublishRelay<Void>()
        let goToFeed = PublishRelay<Void>()
        let openDropdown = PublishRelay<Void>()

        let month = BehaviorRelay<String>(value: {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            return dateFormatter.string(from: Date())
        }())

        let year = BehaviorRelay<String>(value: {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            return dateFormatter.string(from: Date())
        }())
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
                owner.output.challenge.onNext(challengeMain)
            },
                        onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
            .disposed(by: disposeBag)
    }

    func bindChallengeStamp() {
        challengeService.getChallengeStamp(month: output.month.value, year: output.year.value)
            .withUnretained(self)
            .subscribe(onNext: { owner, challengeStamp in
                owner.output.challangeStamp.onNext(challengeStamp)
            },
                       onError: { [weak self] error in
                self?.output.showError.accept(error)
            })
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

        input.selectMonthButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.openDropdown.accept(())
            }
            .disposed(by: disposeBag)

        output.month
            .withUnretained(self)
            .bind { owner, _ in
                owner.bindChallengeStamp()
            }
            .disposed(by: disposeBag)

        output.year
            .withUnretained(self)
            .bind { owner, _ in
                owner.bindChallengeStamp()
            }
            .disposed(by: disposeBag)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

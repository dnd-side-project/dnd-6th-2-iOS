//
//  RelayDetailViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxSwift
import RxCocoa

class RelayDetailViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    var isNew: Bool = false

    struct Input {
        let enterButtonTap = PublishSubject<Void>()
        let participantButtonTap = PublishSubject<Void>()
    }

    struct Output {
        let goToRoom = PublishRelay<Void>()
        let goToParticipantView = PublishRelay<Void>()
    }

    var input: Input
    var output: Output

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        bindEnterRoom()
        bindParticipant()
    }

    private var currentViewState: RelayRoomState = .nonParticipation

    func bindEnterRoom() {
        input.enterButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToRoom.accept(())
            }
            .disposed(by: disposeBag)
    }

    func bindParticipant() {
        input.participantButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goToParticipantView.accept(())
            }
            .disposed(by: disposeBag)
    }
}

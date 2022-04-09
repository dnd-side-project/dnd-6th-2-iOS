//
//  MakingRelayRoomViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class MakingRelayRoomModel: ViewModelType {

    var disposeBag = DisposeBag()
    var rootView: UIViewController?

    struct Input {

        let backButtonTap = PublishSubject<Void>()

        let addingTagButtonTap = PublishSubject<String>()
        let originalTagList = PublishSubject<[String]>()

        let title = PublishSubject<String>()
        let notice = PublishSubject<String>()

        let plusButtonTap = PublishSubject<Void>()
        let minusButtonTap = PublishSubject<Void>()

        let startButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let goBack = PublishRelay<Void>()
        let tagList = BehaviorRelay<[SectionModel<String, String>]>(value: [])

        let goToSelectTag = PublishRelay<Void>()

        let enableStartButton = PublishRelay<Bool>()
        let goToNewRelay = PublishRelay<Relay>()

        let personnelCount = BehaviorRelay<Int>(value: 0)
    }

    var input: Input
    var output: Output

    let relayService = RelayService()

    var relayDTO = CreateRelayDTO(
        title: "",
        tags: [],
        notice: "",
        headCount: 0
    )

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bindBackButton()
        bindAddingTag()
        bindOriginalTagList()
        bindStartButtonEnable()
        bindStartButtonTap()
        bindPersonnel()
    }

    func bindBackButton() {
        input.backButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goBack.accept(())
            }
            .disposed(by: disposeBag)
    }

    func bindTagList() {
        output.tagList.accept(
            [SectionModel(model: "", items: [StringType.addTagString])]
        )
    }

    func bindOriginalTagList() {
        input.originalTagList
            .withUnretained(self)
            .bind { owner, tagArray in
                owner.relayDTO.tags = tagArray
                var newArray = tagArray
                newArray.append(StringType.addTagString)
                owner.output.tagList.accept(
                    [SectionModel(model: "", items: newArray)]
                )
            }
            .disposed(by: disposeBag)
    }

    func bindStartButtonEnable() {
        Observable.combineLatest(input.title, input.notice)
            .map {[weak self] title, notice in
                if title == StringType.titlePlaceeholder ||
                    notice == StringType.noticePlaceholder {
                    return false
                }
                self?.relayDTO.title = title
                self?.relayDTO.notice = notice
                return true
            }
            .bind(to: output.enableStartButton)
            .disposed(by: disposeBag)

    }

    func bindStartButtonTap() {

        input.startButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.relayService.postRelayRoom(relay: owner.relayDTO)
                    .bind { relay in
                        owner.output.goToNewRelay.accept(relay)
                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
    }

    func bindPersonnel() {
        input.minusButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                if owner.output.personnelCount.value > 0 {
                    let personnel = owner.output.personnelCount.value-1
                    owner.output.personnelCount.accept(personnel)
                    owner.relayDTO.headCount = personnel
                }
            }
            .disposed(by: disposeBag)

        input.plusButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                if owner.output.personnelCount.value < 10 {
                    let personnel = owner.output.personnelCount.value+1
                    owner.output.personnelCount.accept(personnel)
                    owner.relayDTO.headCount = personnel
                }
            }
            .disposed(by: disposeBag)
    }

    func bindAddingTag() {
        input.addingTagButtonTap
            .withUnretained(self)
            .bind { owner, model in
                if model == "태그 추가" {
                    owner.output.goToSelectTag.accept(())
                }
            }
            .disposed(by: disposeBag)
    }

}

//
//  SelectTagViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SelectTagViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    var checkSelectedTags = [String: Bool]()

    struct Input {
        let backButtonTap = PublishSubject<Void>()
        let tagTap = PublishSubject<String>()
        let completeButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let tagList = PublishRelay<[String]>()
        let goBackToMakingView = PublishRelay<Void>()
    }

    var input: Input
    var output: Output

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bindTagTab()
        bindComplete()
    }

    func bindTagTab() {

        StringType.categories.forEach({ tag in
            checkSelectedTags.updateValue(false, forKey: tag)
        })

        input.tagTap
            .withUnretained(self)
            .bind { owner, model in

                let checked = owner.checkSelectedTags[model] ?? false
                owner.checkSelectedTags.updateValue(!checked, forKey: model)

                var tagArray: [String] = []
                owner.checkSelectedTags.forEach({ tag in
                    if tag.value {
                        tagArray.append(tag.key)
                    }
                })

                owner.output.tagList.accept(tagArray)
            }
            .disposed(by: disposeBag)
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

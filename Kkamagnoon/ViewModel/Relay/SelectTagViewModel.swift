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

    // count: 12
    let tagList = ["일상", "로맨스", "추리", "코믹", "감성", "시", "소설", "글귀", "일기", "수필", "짧은 글", "긴 글"]
    var selectedTags: [String] = []

    var selectedState = [Bool](repeating: false, count: 12)

    struct Input {
        let tagTap = PublishSubject<String>()
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
//        bindTagTab()
        bindComplete()
    }

//    func bindTagTab() {
//        input.tagTap
//            .withUnretained(self)
//            .bind { owner, _ in
//                if owner.selectedTags.count < 6 {
//                    owner.selectedTags.append(<#T##newElement: String##String#>)
//                }
//            }
//            .disposed(by: disposeBag)
//    }

    func bindComplete() {
        input.completeButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.goBackToMakingView.accept(())
            }
            .disposed(by: disposeBag)
    }
}

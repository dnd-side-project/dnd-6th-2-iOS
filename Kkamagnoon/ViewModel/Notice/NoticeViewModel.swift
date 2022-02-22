//
//  NoticeViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa

class NoticeViewModel: ViewModelType {

    var disposeBag = DisposeBag()

    struct Input {

    }

    struct Output {
        let noticeList = BehaviorRelay<[String]>(value: [])
    }

    var input: Input
    var output: Output

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        bindNoticeList()
    }

    func bindNoticeList() {
        // DUMMY

        Observable<[String]>.of(["공지사항", "공지사항", "공지사항"])
            .withUnretained(self)
            .bind { owner, list in
                owner.output.noticeList.accept(list)
            }
            .disposed(by: disposeBag)
    }

}

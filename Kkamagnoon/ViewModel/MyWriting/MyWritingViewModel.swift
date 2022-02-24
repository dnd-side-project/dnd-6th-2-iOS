//
//  MyWritingViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class MyWritingViewModel: ViewModelType {
    struct Input {
        let tagTap = PublishSubject<String>()
        let addWritingButtonTap = PublishSubject<Void>()
        let myWritingCellTap = PublishSubject<Article>()

    }

    struct Output {
        let goToBellNotice = PublishRelay<Void>()
        let goToWriting = PublishRelay<Void>()
        let keyWord = PublishRelay<Keyword>()
    }

    var input: Input
    var output: Output

    var disposeBag = DisposeBag()
//    var myWritingService = MyWritingService()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        bind()
    }

}

extension MyWritingViewModel {
    func bind() {

    }
}

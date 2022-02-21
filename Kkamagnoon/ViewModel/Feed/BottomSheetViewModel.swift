//
//  BottomSheetViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import RxSwift
import RxCocoa

class BottomSheetViewModel: ViewModelType {

    var commentList: [Comment]?

    struct Input {
        let backViewTap = PublishSubject<Void>()
        let moreButtonTap = PublishSubject<Void>()
        let sendButtonTap = PublishSubject<Void>()

    }

    struct Output {
        let dismissView = PublishRelay<Void>()

        // TODO: 댓글 게시
    }

    var input: Input
    var output: Output

    var commentService: FeedCommentService

    var disposeBag = DisposeBag()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        self.commentService = FeedCommentService()

        bind()
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension BottomSheetViewModel {
    func bind() {
        input.backViewTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.dismissView.accept(())
            }
            .disposed(by: disposeBag)

        input.sendButtonTap
            .withUnretained(self)
            .bind { _, _ in
                // TODO: SEND COMMENT!!
//                owner.commentService.postComment(articleId: <#T##String#>, content: <#T##String#>)
            }
            .disposed(by: disposeBag)
    }

}

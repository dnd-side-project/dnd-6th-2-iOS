//
//  BottomSheetViewModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import RxSwift
import RxCocoa
import RxDataSources

class BottomSheetViewModel: ViewModelType {

    var commentString: String = ""

    struct Input {
        let content = PublishSubject<String>()
        let backViewTap = PublishSubject<Void>()
        let moreButtonTap = PublishSubject<Void>()
        let sendButtonTap = PublishSubject<Void>()
        let articleId = BehaviorRelay<String>(value: "")

    }

    struct Output {
        let dismissView = PublishRelay<Void>()
        let enableSendButton = BehaviorRelay<Bool>(value: false)
        let commentList = BehaviorRelay<[SectionModel<String, Comment>]>(value: [])
        // TODO: 댓글 게시
    }

    var input: Input
    var output: Output

    var feedService: FeedService
    var commentService: FeedCommentService

    var disposeBag = DisposeBag()

    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output

        self.feedService = FeedService()
        self.commentService = FeedCommentService()

        bind()
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension BottomSheetViewModel {

    func bindComment() {
        commentService.getComment(articleId: input.articleId.value)
            .withUnretained(self)
            .bind { _, comments in
                self.output.commentList.accept([SectionModel(model: "", items: comments)])
            }
            .disposed(by: disposeBag)
    }

    func bind() {
        input.backViewTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.dismissView.accept(())
            }
            .disposed(by: disposeBag)

        input.content
            .withUnretained(self)
            .map { owner, str -> Bool in
                if !str.isEmpty {
                    owner.commentString = str
                    print("!!!\(owner.commentString)")
                    return true
                } else {
                    return false
                }
            }
            .bind(to: output.enableSendButton)
            .disposed(by: disposeBag)

        input.sendButtonTap
            .withUnretained(self)
            .bind { owner, _ in
                owner.commentService.postComment(articleId: owner.input.articleId.value, content: owner.commentString)
                    .bind { res in
                        print(">>>commentRes: \(res)")
                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)

    }

}

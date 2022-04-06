//
//  DetailMyWritingViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/27.
//

import UIKit
import RxSwift
import RxCocoa

class DetailMyWritingViewController: DetailContentViewController {

    let detailViewModel = DetailMyWritingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindDetailView()
        detailViewModel.bindArticle()
    }

    func bindDetailView() {

        detailViewModel.output.article
            .withUnretained(self)
            .bind { owner, article in
                owner.detailView.titleLabel.text = article.title
                owner.detailView.profileView.nickNameLabel.text = article.user?.nickname
                owner.detailView.contentLabel.text = article.content

                // TODO: Created Date

                owner.bottomView.likeButton.setTitle("\(article.likeNum ?? 0)", for: .normal)
                owner.bottomView.commentButton.setTitle("\(article.commentNum ?? 0)", for: .normal)
                owner.bottomView.bookmarkButton.setTitle("\(article.scrapNum ?? 0)", for: .normal)
            }
            .disposed(by: disposeBag)
    }

}

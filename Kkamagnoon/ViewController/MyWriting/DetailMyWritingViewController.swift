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
    }

    func bindDetailView() {

        detailViewModel.output.article
            .asDriver()
            .drive(onNext: setArticleData)
            .disposed(by: disposeBag)
    }

    override func bindData() {
        detailViewModel.bindArticle()
    }

    private func setArticleData(_ article: Article) {
        detailView.titleLabel.text = article.title
        detailView.profileView.nickNameLabel.text = article.user?.nickname
        detailView.contentLabel.text = article.content

        let date = stringToDateFormatter.date(from: article.updatedAt ?? "") ?? Date()
        detailView.updateDateLabel.text = "\(dateToStringFormatter.string(from: date))"

        bottomView.likeButton.setTitle("\(article.likeNum ?? 0)", for: .normal)
        bottomView.commentButton.setTitle("\(article.commentNum ?? 0)", for: .normal)
        bottomView.bookmarkButton.setTitle("\(article.scrapNum ?? 0)", for: .normal)
    }

}

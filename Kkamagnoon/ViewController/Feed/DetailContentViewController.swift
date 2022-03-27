//
//  DetailContentViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

import Then
import SnapKit

class DetailContentViewController: UIViewController {

    var viewModel = DetailContentViewModel()

    var stackView = UIStackView()
          .then {
              $0.axis = .vertical
              $0.spacing = 0
              $0.alignment = .fill
              $0.distribution = .fill
          }

    var backButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Back"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 18)
        }

    var scrollView = UIScrollView()
          .then {
              $0.showsVerticalScrollIndicator = false
              $0.setContentHuggingPriority(.defaultLow, for: .vertical)
          }

    var bottomView = BottomReactionView()
        .then {
            $0.frame.size.height = 45
            $0.setContentHuggingPriority(.required, for: .vertical)
        }

    var detailView: FeedDetailView!

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        navigationController?.isNavigationBarHidden = true

        setView()
        layoutView()
        bindInput()
        bindOutput()
        viewModel.bindArticle()

    }

}

extension DetailContentViewController {
    func setView() {

        let article = viewModel.output.article.value

        view.addSubview(backButton)
        view.addSubview(stackView)
        stackView.addArrangedSubview(scrollView)
        stackView.addArrangedSubview(bottomView)

        detailView = FeedDetailView(frame: .zero, tags: article.tags ?? [])

        scrollView.addSubview(detailView)

//        detailView.titleLabel.text = article.title
//        detailView.profileView.nickNameLabel.text = article.user?.nickname
//        detailView.contentTextView.text = article.content
//
//        // TODO: Created Date
//
//        bottomView.likeButton.setTitle("\(article.likeNum ?? 0)", for: .normal)
//        bottomView.commentButton.setTitle("\(article.commentNum ?? 0)", for: .normal)
//        bottomView.bookmarkButton.setTitle("\(article.scrapNum ?? 0)", for: .normal)
    }

    func layoutView() {
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.size.equalTo(28)
            // TEMP
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10.0)
        }

        stackView.snp.makeConstraints {
            // TEMP
            $0.top.equalTo(backButton.snp.bottom).offset(10.0)

            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        scrollView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }

        bottomView.snp.makeConstraints {
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(-48.0)
        }

        detailView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}

extension DetailContentViewController {
    func bindInput() {

        backButton.rx.tap
            .bind(to: viewModel.input.backButtonTap)
            .disposed(by: disposeBag)

        detailView.profileView.subscribeStatus.rx.tap
            .bind(to: viewModel.input.subscribeButtonTap)
            .disposed(by: disposeBag)

        detailView.moreButton.rx.tap
            .bind(to: viewModel.input.moreButtonTap)
            .disposed(by: disposeBag)

        bottomView.likeButton.rx.tap
            .bind(to: viewModel.input.likeButtonTap)
            .disposed(by: disposeBag)

        bottomView.commentButton.rx.tap
            .bind(to: viewModel.input.commentButtonTap)
            .disposed(by: disposeBag)

        bottomView.bookmarkButton.rx.tap
            .bind(to: viewModel.input.scrapButtonTap)
            .disposed(by: disposeBag)
    }

    func bindOutput() {
        // TODO: 구독하기 반영

        viewModel.output.article
            .withUnretained(self)
            .bind { owner, article in
                owner.detailView.titleLabel.text = article.title
                owner.detailView.profileView.nickNameLabel.text = article.user?.nickname
                owner.detailView.contentTextView.text = article.content

                // TODO: Created Date

                owner.bottomView.likeButton.setTitle("\(article.likeNum ?? 0)", for: .normal)
                owner.bottomView.commentButton.setTitle("\(article.commentNum ?? 0)", for: .normal)
                owner.bottomView.bookmarkButton.setTitle("\(article.scrapNum ?? 0)", for: .normal)
            }
            .disposed(by: disposeBag)

        viewModel.output.popBack
            .withUnretained(self)
            .bind { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToReport
            .withUnretained(self)
            .bind { _, _ in

            }
            .disposed(by: disposeBag)

        viewModel.output.like
            .withUnretained(self)
            .bind { owner, likenum in
                owner.bottomView.likeButton.setTitle(String(likenum), for: .normal)
                owner.bottomView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToCommentPage
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToCommentVC()
            }
            .disposed(by: disposeBag)

        viewModel.output.scrap
            .withUnretained(self)
            .bind { owner, scrapnum in
                owner.bottomView.bookmarkButton.setTitle(String(scrapnum), for: .normal)
                owner.bottomView.bookmarkButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            .disposed(by: disposeBag)

    }
}

extension DetailContentViewController {
    func goToCommentVC() {
        let vc = BottomSheetViewController()
        vc.viewModel.input.articleId.accept(viewModel.input.articleId.value)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

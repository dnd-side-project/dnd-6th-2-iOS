//
//  DetailContentViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Then
import SnapKit

class DetailContentViewController: UIViewController {

    var viewModel = DetailContentViewModel()

    let stringToDateFormatter = DateFormatter()
        .then {
            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        }

    let dateToStringFormatter = DateFormatter()
        .then {
            $0.dateFormat = "yyyy년 MM월 dd일"
        }

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

    var detailView = FeedDetailView()
        .then {
            $0.tagListView.filterView.allowsSelection = false
            $0.tagListView.filterView.register(
                CategoryFilterCell.self,
                forCellWithReuseIdentifier: CategoryFilterCell.categoryFilterCellIdentifier)
        }

    var disposeBag = DisposeBag()

    lazy var tagDatasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryFilterCell.categoryFilterCellIdentifier, for: indexPath) as! CategoryFilterCell

        cell.tagView.categoryLabel.text = element

        return cell
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        navigationController?.isNavigationBarHidden = true

        setLayout()
        bindInput()
        bindOutput()
        bindData()
    }

    func bindData() {
        viewModel.bindArticle()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        viewModel.bindArticle()
//    }

}

extension DetailContentViewController {

    func setLayout() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.size.equalTo(28)
            // TEMP
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10.0)
        }

        view.addSubview(stackView)
        stackView.addArrangedSubview(scrollView)
        stackView.addArrangedSubview(bottomView)

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

        scrollView.addSubview(detailView)

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
            .asDriver()
            .drive(onNext: setDetailViewData)
            .disposed(by: disposeBag)

        viewModel.output.popBack
            .asSignal()
            .emit(onNext: popToBackView)
            .disposed(by: disposeBag)

        viewModel.output.goToReport
            .withUnretained(self)
            .bind { _, _ in

            }
            .disposed(by: disposeBag)

        viewModel.output.like
            .asDriver()
            .drive(onNext: updateLikeView)
            .disposed(by: disposeBag)

        viewModel.output.goToCommentPage
            .asSignal()
            .emit(onNext: goToCommentVC)
            .disposed(by: disposeBag)

        viewModel.output.scrap
            .asDriver()
            .drive(onNext: updateScrapView)
            .disposed(by: disposeBag)

        viewModel.output.tags
            .asDriver()
            .drive(detailView.tagListView.filterView.rx.items(dataSource: tagDatasource))
            .disposed(by: disposeBag)

    }
}

extension DetailContentViewController {
    private func goToCommentVC() {
        let vc = BottomSheetViewController()
        vc.viewModel.input.articleId.accept(viewModel.input.articleId.value)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }

    private func setDetailViewData(_ article: Article) {

        detailView.titleLabel.text = article.title
        detailView.profileView.nickNameLabel.text = article.user?.nickname
        detailView.contentLabel.text = article.content

        let date = stringToDateFormatter.date(from: article.updatedAt ?? "" ) ?? Date()
        detailView.updateDateLabel.text = dateToStringFormatter.string(from: date)

        bottomView.likeButton.setTitle("\(article.likeNum ?? 0)", for: .normal)
        bottomView.commentButton.setTitle("\(article.commentNum ?? 0)", for: .normal)
        bottomView.bookmarkButton.setTitle("\(article.scrapNum ?? 0)", for: .normal)
    }

    private func popToBackView() {
        self.navigationController?.popViewController(animated: true)
    }

    private func updateLikeView(_ likeNum: Int) {
        bottomView.bookmarkButton.setTitle(String(likeNum), for: .normal)
//                bottomView.bookmarkButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }

    private func updateScrapView(_ scrapNum: Int) {
        bottomView.bookmarkButton.setTitle(String(scrapNum), for: .normal)
//                bottomView.bookmarkButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
}

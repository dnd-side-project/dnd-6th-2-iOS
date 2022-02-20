//
//  NewFeedViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

class FeedViewController: UIViewController {

    let viewModel = FeedViewModel()
    let disposeBag = DisposeBag()

    let topButtonView = TopButtonView(frame: .zero, first: StringType.wholeFeed, second: StringType.subscribeFeed)

    let wholeFeedView = WholeFeedView()
    let subscribeFeedView = SubscribeFeedView()

    var feedView: FeedView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        feedView = wholeFeedView

        setTopView()
        setFeedView()

        bindTopView()

        viewModel.getWholeFeedList()
//        viewModel.getSubscribeFeedList()

        bindWholeFeedViewData()
        bindSubscribeFeedViewData()
    }

    func setTopView() {
        view.addSubview(topButtonView)
        topButtonView.translatesAutoresizingMaskIntoConstraints = false

        topButtonView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topButtonView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topButtonView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topButtonView.heightAnchor.constraint(equalToConstant: 115).isActive = true

    }

    func setFeedView() {
        view.addSubview(feedView)
        feedView.translatesAutoresizingMaskIntoConstraints = false

        feedView.topAnchor.constraint(equalTo: topButtonView.bottomAnchor).isActive = true
        feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        feedView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        feedView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    }

    func bindTopView() {

        topButtonView.firstButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.topButtonView.searchButton.isHidden = false
                owner.feedView.removeFromSuperview()
                owner.feedView = owner.wholeFeedView
                owner.setFeedView()

            }
            .disposed(by: disposeBag)

        topButtonView.secondButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.topButtonView.searchButton.isHidden = true
                owner.feedView.removeFromSuperview()
                owner.feedView = owner.subscribeFeedView
                owner.setFeedView()
            }
            .disposed(by: disposeBag)
    }

    func bindWholeFeedViewData() {

        // DUMMY
        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        dummyData.bind(to: wholeFeedView.articleListView.collectionView
                        .rx.items(cellIdentifier: FeedCell.feedCellIdentifier,
                                             cellType: FeedCell.self)) { (_, element, cell) in
            cell.articleTitle.text = element
            cell.layer.cornerRadius = 15
            }
        .disposed(by: disposeBag)

        wholeFeedView.articleListView.collectionView.rx
            .itemSelected
            .bind { _ in
                let vc = DetailContentViewController()
                vc.modalPresentationStyle = .pageSheet
                vc.hidesBottomBarWhenPushed = true

                self.navigationController?.pushViewController(vc, animated: true)

            }
            .disposed(by: disposeBag)
    }

    func bindSubscribeFeedViewData() {

        // DUMMY
        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        dummyData.bind(to: subscribeFeedView.articleListView.collectionView
                        .rx.items(cellIdentifier: FeedCell.feedCellIdentifier,
                                             cellType: FeedCell.self)) { (_, element, cell) in
            cell.articleTitle.text = element
            cell.layer.cornerRadius = 15
            }
        .disposed(by: disposeBag)

        subscribeFeedView.articleListView.collectionView.rx
            .itemSelected
            .bind { _ in
                let vc = DetailContentViewController()
                vc.modalPresentationStyle = .pageSheet
                vc.hidesBottomBarWhenPushed = true

                self.navigationController?.pushViewController(vc, animated: true)

            }
            .disposed(by: disposeBag)
    }

}

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
        bindSortButton()

        bindWholeFeedView()
        bindSubscribeFeedView()

        viewModel.tempRequest()
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

        // Input
        topButtonView.firstButton.rx.tap
            .bind(to: viewModel.input.wholeFeedButtonTap)
            .disposed(by: disposeBag)

        topButtonView.secondButton.rx.tap
            .bind(to: viewModel.input.subscribedFeedButtonTap)
            .disposed(by: disposeBag)

        topButtonView.searchButton.rx.tap
            .bind(to: viewModel.input.searchButtonTap)
            .disposed(by: disposeBag)

        topButtonView.bellButton.rx.tap
            .bind(to: viewModel.input.bellButtonTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.currentFeedStyle
            .asDriver()
            .drive { [weak self] feedStyle in
                guard let self = self else {return}
                self.changeFeedStyle(style: feedStyle)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToSearch
            .observe(on: MainScheduler.instance)
            .bind(onNext: goToSearchVC)
            .disposed(by: disposeBag)

        viewModel.output.goToBell
            .observe(on: MainScheduler.instance)
            .bind(onNext: goToBellVC)
            .disposed(by: disposeBag)

    }

    func bindSortButton() {
        wholeFeedView.sortButton.rx.tap
            .bind(to: viewModel.input.sortButtonTap)
            .disposed(by: disposeBag)

        viewModel.output.currentSortStyle
            .asDriver()
            .drive { [weak self] sortStyle in
                guard let self = self else {return}
                self.changeSortStyle(style: sortStyle)
            }
            .disposed(by: disposeBag)
    }

    func bindWholeFeedView() {

        viewModel.output.wholeFeedListRelay
            .bind(to: wholeFeedView.articleListView.collectionView
                    .rx.items(cellIdentifier: FeedCell.feedCellIdentifier,
                                         cellType: FeedCell.self)) { (_, element, cell) in
                cell.articleTitle.text = element
                cell.layer.cornerRadius = 15
            }
            .disposed(by: disposeBag)

        // Input
        wholeFeedView.articleListView.collectionView.rx
            .itemSelected
            .bind(to: viewModel.input.feedCellTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.goToDetailFeed
            .observe(on: MainScheduler.instance)
            .bind { _ in
                self.goToDetailContentVC()
            }
            .disposed(by: disposeBag)

    }

    func bindSubscribeFeedView() {
        viewModel.bindSubscribedFeedList()
        viewModel.output.subscribeFeedListRelay
            .bind(to: subscribeFeedView.articleListView.collectionView
                    .rx.items(cellIdentifier: FeedCell.feedCellIdentifier,
                                         cellType: FeedCell.self)) { (_, element, cell) in
                cell.articleTitle.text = element
                cell.layer.cornerRadius = 15
                }
            .disposed(by: disposeBag)

        subscribeFeedView.articleListView.collectionView.rx
            .modelSelected(String.self)
            .bind { _ in
                self.goToDetailContentVC()
            }
            .disposed(by: disposeBag)
    }

    private func changeFeedStyle(style: FeedStyle) {
        feedView.removeFromSuperview()

        if style == .whole {
            feedView = wholeFeedView
        } else {
            feedView = subscribeFeedView
        }
        setFeedView()
    }

    private func goToSearchVC() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToBellVC() {
        let vc = BellNoticeViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func changeSortStyle(style: SortStyle) {
        if style == .byLatest {
            // TODO: 목록 변경
            feedView.sortButton.setTitle("최신순", for: .normal)
        } else {
            // TODO: 목록 변경
            feedView.sortButton.setTitle("인기순", for: .normal)
        }
    }

    private func goToDetailContentVC() {

        let vc = DetailContentViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        // TODO
        // vc.feedInfo = indexPath.row 의 feedInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

//
//  NewFeedViewController.swift
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

class FeedViewController: BaseViewController {

    var feedView: UIView!
    let viewModel = FeedViewModel()
    let disposeBag = DisposeBag()

    let stringToDateFormatter = DateFormatter()
        .then {
            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        }

    let dateToStringFormatter = DateFormatter()
        .then {
            $0.dateFormat = "yyyy년 MM월 dd일"
        }

    let topButtonView = TopButtonView(
        frame: .zero,
        first: StringType.wholeFeed,
        second: StringType.subscribeFeed
    )
        .then {
            $0.searchButton.setImage(UIImage(named: "Search"), for: .normal)
            $0.bellButton.setImage(UIImage(named: "Bell"), for: .normal)
        }

    let wholeFeedView = WholeFeedView()
        .then {
            $0.filterView.filterView.register(CategoryFilterCell.self, forCellWithReuseIdentifier: CategoryFilterCell.categoryFilterCellIdentifier)
        }

    let subscribeFeedView = SubscribeFeedView()

    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<FeedSection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeedCell.feedCellIdentifier,
            for: indexPath
        ) as! FeedCell

        self.setFeedCellData(cell: cell, element: element)

        return cell
    },
    configureSupplementaryView: { _, collectionView, _, indexPath in
        let sortHeaderView = collectionView
            .dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: SortHeaderCell.sortHeaderCellReuseIdentifier,
                for: indexPath
            ) as! SortHeaderCell

        self.setHeaderViewHandler(sortHeaderView: sortHeaderView)
        return sortHeaderView
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        feedView = wholeFeedView
        setLayout()
        bindInput()
        bindOutput()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.bindWholeFeedList(cursor: nil, pagination: false)
    }
}

extension FeedViewController {

    func setLayout() {
        view.addSubview(topButtonView)
        topButtonView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(115)
        }

        setFeedView()
    }

    func setFeedView() {
        view.addSubview(feedView)
        feedView.snp.makeConstraints {
            $0.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(topButtonView.snp.bottom)
        }
    }
}

extension FeedViewController {
    func bindInput() {
        // header
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

        // whole feed
        wholeFeedView.filterView.filterView.rx
            .modelSelected(String.self)
            .bind(to: viewModel.input.tagCellTap)
            .disposed(by: disposeBag)

        wholeFeedView.filterView.filterView.rx
            .modelDeselected(String.self)
            .bind(to: viewModel.input.tagCellTap)
            .disposed(by: disposeBag)

        wholeFeedView.articleListView.collectionView.rx
            .modelSelected(Article.self)
            .bind(to: viewModel.input.feedCellTap)
            .disposed(by: disposeBag)

        // subscribe feed
        subscribeFeedView.articleListView.collectionView.rx
            .modelSelected(Article.self)
            .bind(to: viewModel.input.feedCellTap)
            .disposed(by: disposeBag)

        subscribeFeedView.goAllListButton.rx.tap
            .bind(to: viewModel.input.allSubscriberButtonTap)
            .disposed(by: disposeBag)

    }

    func bindOutput() {

        viewModel.output.goToSearch
            .asSignal()
            .emit(onNext: goToSearchVC)
            .disposed(by: disposeBag)

        viewModel.output.goToBell
            .asSignal()
            .emit(onNext: goToBellVC)
            .disposed(by: disposeBag)

        viewModel.output.tagList
            .asDriver(onErrorJustReturn: StringType.categories)
            .drive(wholeFeedView.filterView.filterView.rx.items(
                cellIdentifier: CategoryFilterCell.categoryFilterCellIdentifier,
                cellType: CategoryFilterCell.self)) { (_, element, cell) in
                    cell.tagView.categoryLabel.text = element
                }
                .disposed(by: disposeBag)

        viewModel.output.wholeFeedList
            .asDriver()
            .drive(wholeFeedView
                    .articleListView
                    .collectionView
                    .rx
                    .items(dataSource: dataSource)
            )
            .disposed(by: disposeBag)

        viewModel.output.goToDetailFeed
            .asSignal()
            .emit(onNext: goToDetailContentVC(_:))
            .disposed(by: disposeBag)

        // TODO: asDriver
        viewModel.output.subscribeFeedList
            .bind(to: subscribeFeedView.articleListView.collectionView
                    .rx.items(
                        cellIdentifier: FeedCell.feedCellIdentifier,
                        cellType: FeedCell.self
                    )
            ) { (_, _, _) in

            }
            .disposed(by: disposeBag)

        viewModel.output.goToAllSubscriberList
            .asSignal()
            .emit(onNext: goToAllSubscribe(_:))
            .disposed(by: disposeBag)

        viewModel.output.showError
            .asSignal()
            .emit(onNext: showError)
            .disposed(by: disposeBag)
    }
}

extension FeedViewController {
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

    private func goToDetailContentVC(_ article: Article) {

        let vc = DetailContentViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        vc.viewModel.input.articleId.accept(article._id ?? "")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToAllSubscribe(_ authorList: [Host]) {
        let vc = SubscribeListViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.input.authorList.accept(authorList)

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func setHeaderViewHandler(sortHeaderView: SortHeaderCell) {
        sortHeaderView.buttonTappedHandler = { [unowned self] in
            if self.viewModel.output.sortStyle.value == .byLatest {
                sortHeaderView.sortButton.setTitle("인기순", for: .normal)
                self.viewModel.output.sortStyle.accept(.byPopularity)
            } else {
                sortHeaderView.sortButton.setTitle("최신순", for: .normal)
                self.viewModel.output.sortStyle.accept(.byLatest)
            }

            viewModel.bindWholeFeedList(cursor: nil, pagination: false)
        }
    }

    private func setFeedCellData(cell: FeedCell, element: Article) {
        // TODO: Save my id to User Defaults
        if element.user?._id == "MyId" {
            cell.backgroundColor = UIColor(rgb: 0x292929)
        }

        cell.profileView.nickNameLabel.text = element.user?.nickname
        cell.articleTitle.text = element.title

        cell.articleContents.setTextWithLineHeight(
            text: element.content,
            lineHeight: .lineheightInBox
        )

        let date = stringToDateFormatter.date(from: element.updatedAt ?? "")!

        cell.updateDate.text = dateToStringFormatter.string(from: date)
        cell.likeView.labelView.text = "\(element.likeNum ?? 0)"
        cell.commentView.labelView.text = "\(element.commentNum ?? 0)"
    }
}

extension FeedViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = scrollView.contentOffset.y

        let wholeFeedViewContentSize = wholeFeedView.articleListView.collectionView.contentSize.height

        let subscribeFeedViewContentSize = subscribeFeedView.articleListView.collectionView.contentSize.height

        let currentStyle = viewModel.output.currentFeedStyle.value

        let wholeFeedPagination_y = wholeFeedViewContentSize*0.4
        let subscribeFeedPagination_y = subscribeFeedViewContentSize*0.4

        if currentStyle == .whole {
            if contentOffset_y > wholeFeedViewContentSize - wholeFeedPagination_y {

                let nowCursor = viewModel.output.wholeFeedCursor.value
                if nowCursor != "" {
                    viewModel.bindWholeFeedList(cursor: nowCursor, pagination: true)
                }
            }
        } else {
            if contentOffset_y > subscribeFeedViewContentSize - subscribeFeedPagination_y {

                let nowCursor = viewModel.output.subscribeFeedCursor.value
                if nowCursor != "" {
                    viewModel.bindSubscribedFeedList(cursor: nowCursor, pagination: true)
                }
            }
        }

    }
}

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

class FeedViewController: UIViewController {

    var feedView: UIView!

    let viewModel = FeedViewModel()
    let disposeBag = DisposeBag()

    let topButtonView = TopButtonView(frame: .zero, first: StringType.wholeFeed, second: StringType.subscribeFeed)

    let wholeFeedView = WholeFeedView()

    let subscribeFeedView = SubscribeFeedView()

    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<FeedSection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.feedCellIdentifier, for: indexPath) as! FeedCell

        cell.profileView.nickNameLabel.text = element.user?.nickname
        cell.articleTitle.text = element.title

        cell.articleContents.setTextWithLineHeight(
            text: element.content,
            lineHeight: .lineheightInBox
        )
        cell.likeView.labelView.text = "\(element.likeNum ?? 0)"
        cell.commentView.labelView.text = "\(element.commentNum ?? 0)"

        return cell
    },
    configureSupplementaryView: { _, collectionView, _, indexPath in
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SortHeaderCell.sortHeaderCellReuseIdentifier, for: indexPath) as! SortHeaderCell

        headerView.buttonTappedHandler = { [unowned self] in
            if self.viewModel.sortStyle == .byLatest {
                headerView.sortButton.setTitle("인기순", for: .normal)
                self.viewModel.sortStyle = .byPopularity
            } else {
                headerView.sortButton.setTitle("최신순", for: .normal)
                self.viewModel.sortStyle = .byLatest
            }

            viewModel.bindWholeFeedList()
        }

        return headerView
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        feedView = wholeFeedView
        setView()
        bindInput()
        bindOutput()

        viewModel.bindWholeFeedList()
    }
}

extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = scrollView.contentOffset.y
        let collectionViewContentSize = wholeFeedView.articleListView.collectionView.contentSize.height

        let pagination_y = collectionViewContentSize*0.2
        if contentOffset_y > collectionViewContentSize - pagination_y {
            // 네트워크 호출
        }
    }
}

extension FeedViewController {

    func setView() {
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
            .modelSelected(String.self)
            .bind { _ in
//                self.goToDetailContentVC()
            }
            .disposed(by: disposeBag)

        subscribeFeedView.goAllListButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToAllSubscribe()
            }
            .disposed(by: disposeBag)

    }

    func bindOutput() {

//        viewModel.output.currentFeedStyle
//            .asDriver()
//            .drive { [weak self] feedStyle in
//                guard let self = self else {return}
//                self.changeFeedStyle(style: feedStyle)
//            }
//            .disposed(by: disposeBag)

        viewModel.output.goToSearch
            .observe(on: MainScheduler.instance)
            .bind(onNext: goToSearchVC)
            .disposed(by: disposeBag)

        viewModel.output.goToBell
            .observe(on: MainScheduler.instance)
            .bind(onNext: goToBellVC)
            .disposed(by: disposeBag)

        viewModel.output.wholeFeedList
            .bind(to: wholeFeedView.articleListView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToDetailFeed
            .observe(on: MainScheduler.instance)
            .bind { article in
                self.goToDetailContentVC(article: article)
            }
            .disposed(by: disposeBag)

        viewModel.output.subscribeFeedList
            .bind(to: subscribeFeedView.articleListView.collectionView
                    .rx.items(cellIdentifier: FeedCell.feedCellIdentifier,
                                         cellType: FeedCell.self)) { (_, _, _) in

                }
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

    private func goToDetailContentVC(article: Article) {

        let vc = DetailContentViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        // TODO
        // vc.feedInfo = indexPath.row 의 feedInfo
        vc.viewModel.article = article
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToAllSubscribe() {
        let vc = SubscribeListViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

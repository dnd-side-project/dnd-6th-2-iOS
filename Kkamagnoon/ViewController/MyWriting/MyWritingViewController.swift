//
//  MyWritingViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class MyWritingViewController: UIViewController {

    let viewModel = MyWritingViewModel()
    var disposeBag = DisposeBag()

    let stringToDateFormatter = DateFormatter()
        .then {
            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        }

    let dateToStringFormatter = DateFormatter()
        .then {
            $0.dateFormat = "yyyy년 MM월 dd일"
        }

    lazy var myWritingDataSource = RxCollectionViewSectionedReloadDataSource<FeedSection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyWritingCell.identifier,
            for: indexPath) as! MyWritingCell

        self.setMyWritingCell(cell: cell, element: element)

        return cell
    })

    lazy var tempWritingDataSource = RxCollectionViewSectionedReloadDataSource<FeedSection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyWritingCell.identifier,
            for: indexPath) as! MyWritingCell

        self.setMyWritingCell(cell: cell, element: element)

        return cell
    })

    var topButtonView = TopButtonView(
        frame: .zero,
        first: StringType.myWriting,
        second: StringType.tempBox)
        .then { topView in
            topView.secondButton.snp.makeConstraints {
                $0.left.equalTo(topView.firstButton.snp.right).offset(12.0)
            }
            topView.searchButton.setImage(UIImage(named: "Search"), for: .normal)
            topView.bellButton.setImage(UIImage(named: "More"), for: .normal)
        }

    var listView: UIView!

    var myWritingListView = MyWritingListView()
        .then {
            $0.tagListView.filterView.allowsMultipleSelection = false
            $0.tagListView.filterView.register(CategoryFilterCell.self,
                                               forCellWithReuseIdentifier: CategoryFilterCell.categoryFilterCellIdentifier)

            $0.writingListView.collectionView.register(MyWritingCell.self,
                                                       forCellWithReuseIdentifier: MyWritingCell.identifier)
        }

    var tempListView = TempListView()

    var addWritingButton = MakingRoomButton()
        .then {
            $0.setImage(UIImage(named: "Pencil"), for: .normal)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setLayout()
        bindInput()
        bindOutput()
        myWritingListView.writingListView.collectionView.delegate = self
        myWritingListView.tagListView.filterView.selectItem(at: IndexPath(item: .zero, section: .zero), animated: false, scrollPosition: [])
        viewModel.bindMyWritingList(cursor: nil, tag: nil, pagination: false)
        viewModel.bindTempWritingList()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addWritingButton.layer.cornerRadius = addWritingButton.frame.size.width / 2
    }

}

extension MyWritingViewController {

    func configureView() {
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        listView = myWritingListView
    }

    func setLayout() {
        view.addSubview(topButtonView)
        topButtonView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(115.0)
        }

        setListView()

        view.addSubview(addWritingButton)
        addWritingButton.snp.makeConstraints {
            $0.size.equalTo(55.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14.0)
        }
    }

    func bindInput() {
        topButtonView.firstButton.rx.tap
            .bind(to: viewModel.input.myWritingTap)
            .disposed(by: disposeBag)

        topButtonView.secondButton.rx.tap
            .bind(to: viewModel.input.tempWritingTap)
            .disposed(by: disposeBag)

        myWritingListView.writingListView.collectionView.rx
            .modelSelected(Article.self)
            .bind(to: viewModel.input.myWritingCellTap)
            .disposed(by: disposeBag)

        myWritingListView.tagListView.filterView.rx
            .modelSelected(String.self)
            .bind(to: viewModel.input.tagTap)
            .disposed(by: disposeBag)

        tempListView.articleListView.collectionView.rx
            .modelSelected(Article.self)
            .bind(to: viewModel.input.myWritingCellTap)
            .disposed(by: disposeBag)

        addWritingButton.rx.tap
            .bind(to: viewModel.input.addWritingButtonTap)
            .disposed(by: disposeBag)
    }

    func bindOutput() {

        viewModel.output.tagList
            .asDriver(onErrorJustReturn: StringType.categories)
            .drive(myWritingListView.tagListView.filterView.rx.items(
                cellIdentifier: CategoryFilterCell.categoryFilterCellIdentifier,
                cellType: CategoryFilterCell.self)) { (_, element, cell) in
                    cell.tagView.categoryLabel.text = element
                }
            .disposed(by: disposeBag)

        viewModel.output.changeListStyle
            .asDriver()
            .drive(onNext: changeViewStyle)
            .disposed(by: disposeBag)

        viewModel.output.myWritingList
            .asDriver()
            .drive(myWritingListView.writingListView.collectionView.rx.items(dataSource: myWritingDataSource))
            .disposed(by: disposeBag)

        viewModel.output.tempWritingList
            .asDriver()
            .drive(tempListView.articleListView.collectionView.rx.items(dataSource: tempWritingDataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToDetail
            .asSignal()
            .emit(onNext: goToDetailVC)
            .disposed(by: disposeBag)

        viewModel.output.goToWriting
            .asSignal()
            .emit(onNext: goToWritingVC)
            .disposed(by: disposeBag)
    }
}

extension MyWritingViewController {
    private func goToDetailVC(article: Article) {
        let vc = DetailMyWritingViewController()
        vc.detailViewModel.input.articleId.accept(article._id ?? "")
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToWritingVC() {
        let vc = WritingViewController()
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func changeViewStyle(style: MyWritingStyle) {
        listView.removeFromSuperview()

        if style == .myWriting {
            listView = myWritingListView
        } else {

            listView = tempListView
        }
        setListView()
    }

    private func setMyWritingCell(cell: MyWritingCell, element: Article) {
        cell.titleLabel.text = element.title
        cell.contentLabel.text = element.content

        let date = stringToDateFormatter.date(from: element.updatedAt ?? "") ?? Date()
        cell.dateLabel.text = "\(dateToStringFormatter.string(from: date))"
        cell.likeLabel.labelView.text = "\(element.likeNum ?? 0)"
        cell.commentLabel.labelView.text = "\(element.commentNum ?? 0)"
    }

    private func setListView() {
        view.addSubview(listView)
        listView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topButtonView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MyWritingViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = scrollView.contentOffset.y
        let collectionViewContentSize = myWritingListView.writingListView.collectionView.contentSize.height

        let pagination_y = collectionViewContentSize*0.4
        if contentOffset_y > collectionViewContentSize - pagination_y {

            let nowCursor = viewModel.output.cursor.value
            if nowCursor != "" {
                viewModel.bindMyWritingList(cursor: nowCursor, tag: viewModel.output.nowTag.value, pagination: true)
            }
        }
    }
}

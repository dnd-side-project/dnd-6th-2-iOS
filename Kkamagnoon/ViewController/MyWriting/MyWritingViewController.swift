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

    lazy var myWritingDataSource = RxCollectionViewSectionedReloadDataSource<FeedSection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWritingCell.identifier, for: indexPath) as! MyWritingCell

        cell.titleLabel.text = element.title
        cell.contentLabel.text = element.content

        cell.likeLabel.labelView.text = "\(element.likeNum ?? 0)"
        cell.commentLabel.labelView.text = "\(element.commentNum ?? 0)"

        return cell
    })

    lazy var tempWritingDataSource = RxCollectionViewSectionedReloadDataSource<FeedSection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWritingCell.identifier, for: indexPath) as! MyWritingCell

        cell.titleLabel.text = element.title
        cell.contentLabel.text = element.content

        cell.likeLabel.labelView.text = "\(element.likeNum ?? 0)"
        cell.commentLabel.labelView.text = "\(element.commentNum ?? 0)"

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

        }

    var tempListView = TempListView()

    var addWritingButton = MakingRoomButton()
        .then {
            $0.setImage(UIImage(named: "Pencil"), for: .normal)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        listView = myWritingListView
        setView()
        bindView()
        viewModel.bindMyWritingList(tag: nil)
        viewModel.bindTempWritingList()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addWritingButton.layer.cornerRadius = addWritingButton.frame.size.width / 2
    }

}

extension MyWritingViewController {

    func setListView() {
        view.addSubview(listView)
        listView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topButtonView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setView() {
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

    func bindView() {
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

        viewModel.output.changeToMyWritingList
            .withUnretained(self)
            .bind { owner, _ in
                owner.changeViewStyle(style: .myWriting)
            }
            .disposed(by: disposeBag)

        viewModel.output.changeToTempWritingList
            .withUnretained(self)
            .bind { owner, _ in
                owner.changeViewStyle(style: .tempWriting)
            }
            .disposed(by: disposeBag)

        viewModel.output.myWritingList
            .bind(to: myWritingListView.writingListView.collectionView.rx.items(dataSource: myWritingDataSource))
            .disposed(by: disposeBag)

        viewModel.output.tempWritingList
            .bind(to: tempListView.articleListView.collectionView.rx.items(dataSource: tempWritingDataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToDetail
            .withUnretained(self)
            .bind { owner, article in
                owner.goToDetailVC(article: article)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToWriting
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToWritingVC()
            }
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

}

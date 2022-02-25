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

    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<FeedSection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWritingCell.identifier, for: indexPath) as! MyWritingCell

        cell.card.titleLabel.text = element.title
        cell.card.contentLabel.text = element.content

        cell.card.likeLabel.labelView.text = "\(element.likeNum ?? 0)"
        cell.card.commentLabel.labelView.text = "\(element.commentNum ?? 0)"

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

    var tagListView = TagListView(frame: .zero, tags: StringType.myWritingTags)

    var writingListView = ArticleListView()
        .then {
            $0.collectionView.register(MyWritingCell.self, forCellWithReuseIdentifier: MyWritingCell.identifier)
        }

    var addWritingButton = MakingRoomButton()
        .then {
            $0.setImage(UIImage(named: "Pencil"), for: .normal)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setView()
        bindView()
        viewModel.bindMyWritingList()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addWritingButton.layer.cornerRadius = addWritingButton.frame.size.width / 2
    }

}

extension MyWritingViewController {
    func setView() {
        view.addSubview(topButtonView)
        topButtonView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(115.0)
        }

        view.addSubview(tagListView)
        tagListView.snp.makeConstraints {
            $0.top.equalTo(topButtonView.snp.bottom)
            $0.left.equalToSuperview().offset(22.0)
            $0.right.equalToSuperview().offset(-22.0)
            $0.height.equalTo(30.0)
        }

        view.addSubview(writingListView)
        writingListView.snp.makeConstraints {
            $0.top.equalTo(tagListView.snp.bottom).offset(16.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        view.addSubview(addWritingButton)
        addWritingButton.snp.makeConstraints {
            $0.size.equalTo(55.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide  ).offset(-14.0)
        }
    }

    func bindView() {
//        writingListView.collectionView.rx
//            .modelSelected(Article.self)
//            .bind(to: viewModel.input.feedCellTap)
//            .disposed(by: disposeBag)

        viewModel.output.articleList
            .bind(to: writingListView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

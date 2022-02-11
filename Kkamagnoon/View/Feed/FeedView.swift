//
//  FeedView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

// protocol FeedViewProtocol {
//    func setFilterView()
//
//    func setSortButton()
//
//    func setFeedMainView()
// }

class FeedView: UIView {

    var filterView: UIView!

    lazy var sortButton: UIButton = UIButton()
    lazy var articleListView = ArticleListView()

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setFilterView()
        setSortButton()
        setFeedMainView()
        setFeedMainViewTop()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setFilterView() { }

    func setSortButton() { }

    func setFeedMainView() {
        addSubview(articleListView)
        articleListView.translatesAutoresizingMaskIntoConstraints = false

        articleListView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 46).isActive = true

        articleListView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        articleListView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        articleListView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        dummyData.bind(to: articleListView.collectionView
                        .rx.items(cellIdentifier: CellIdentifier.feed,
                                             cellType: FeedCell.self)) { (_, element, cell) in
            cell.articleTitle.text = element
            cell.layer.cornerRadius = 15
            }
        .disposed(by: disposeBag)

        articleListView.collectionView.rx
            .itemSelected
            .bind { _ in
                let vc = DetailContentViewController()
                vc.modalPresentationStyle = .pageSheet
                vc.hidesBottomBarWhenPushed = true

                self.viewController?.navigationController?.pushViewController(vc, animated: true)

            }
            .disposed(by: disposeBag)
    }

    func setFeedMainViewTop() { }
}

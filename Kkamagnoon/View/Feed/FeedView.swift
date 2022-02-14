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
        articleListView.collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.feedCellIdentifier)
        addSubview(articleListView)
        articleListView.translatesAutoresizingMaskIntoConstraints = false

        articleListView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 46).isActive = true

        articleListView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        articleListView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        articleListView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }

    func setFeedMainViewTop() { }
}

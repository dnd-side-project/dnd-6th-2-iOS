//
//  SubscribeFeedView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class SubscribeFeedView: UIView {

    var disposeBag = DisposeBag()

    var filterView = AuthorListView()

    var goAllListButton = UIButton()
        .then {
            $0.setTitle("전체", for: .normal)
            $0.setTitleColor(UIColor(rgb: 0x5FCEA0), for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 14)
        }

    var grayLine = GrayBorderView()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.tag)
        }

    lazy var articleListView = ArticleListView()
        .then {
            $0.collectionView.register(
                FeedCell.self,
                forCellWithReuseIdentifier: FeedCell.feedCellIdentifier
            )
            $0.collectionView.contentInset.top = 15.0
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setFeedMainViewTop() {
        articleListView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 15).isActive = true
    }
}

extension SubscribeFeedView {
    func setView() {
        self.addSubview(filterView)
        filterView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.top.equalToSuperview()
            $0.height.equalTo(106.0)
        }

        self.addSubview(goAllListButton)
        goAllListButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(filterView)
            $0.width.equalTo(83.0)
            $0.left.equalTo(filterView.snp.right)
        }

        self.addSubview(grayLine)
        grayLine.snp.makeConstraints {
            $0.top.equalTo(filterView.snp.bottom).offset(19.0)
            $0.left.right.equalToSuperview()
        }

        self.addSubview(articleListView)
        articleListView.snp.makeConstraints {
            $0.top.equalTo(grayLine.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }

    }
}

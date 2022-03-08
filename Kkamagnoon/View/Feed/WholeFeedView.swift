//
//  WholeFeedView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class WholeFeedView: UIView {

    var filterView = TagListView(frame: .zero, tags: StringType.categories)

    lazy var articleListView = ArticleListView()
        .then {
            $0.collectionView.register(
                FeedCell.self,
                forCellWithReuseIdentifier: FeedCell.feedCellIdentifier
            )
            $0.collectionView.register(
                SortHeaderCell.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: SortHeaderCell.sortHeaderCellReuseIdentifier)
            $0.layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 40)
            $0.collectionView.collectionViewLayout = $0.layout
        }

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
}

extension WholeFeedView {
    func setView () {
        self.addSubview(filterView)
        filterView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalToSuperview()
            $0.height.equalTo(29.0)
        }

        self.addSubview(articleListView)
        articleListView.snp.makeConstraints {
            $0.top.equalTo(filterView.snp.bottom).offset(11.0)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }
    }
}

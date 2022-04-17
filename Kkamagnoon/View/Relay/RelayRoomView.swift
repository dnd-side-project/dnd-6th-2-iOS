//
//  RelayRoomView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class RelayRoomView: UIView {

    var categoryFilterView = TagListView()

    var relayList = ArticleListView()
        .then {
            $0.collectionView.register(RelayRoomCell.self, forCellWithReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier)
            $0.collectionView.register(SortHeaderCell.self,
                                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                       withReuseIdentifier: SortHeaderCell.sortHeaderCellReuseIdentifier)

            $0.layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 40)
            $0.collectionView.collectionViewLayout = $0.layout
        }

    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setView()
    }

}

extension RelayRoomView {
    func setView() {
        self.addSubview(categoryFilterView)

        categoryFilterView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalToSuperview()
            $0.height.equalTo(29.0)
        }

        self.addSubview(relayList)

        relayList.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(categoryFilterView.snp.bottom).offset(11.83)
        }

    }
}

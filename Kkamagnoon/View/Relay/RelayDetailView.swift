//
//  RelayDetailView.swift
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

class RelayDetailView: UIView {

    var disposeBag = DisposeBag()

    var header = HeaderViewWithBackBtn()

    var relayWritingList = ArticleListView()
        .then {
            $0.layout.sectionInset.top = 10.0
            $0.layout.sectionInset.bottom = TabBarViewController.tabbarHeight + 30.0
        }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setHeader()
        setCollectionView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setHeader() {
        self.addSubview(header)
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }

    func setCollectionView() {
        self.addSubview(relayWritingList)

        relayWritingList.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(15.0)
//            $0.width.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()

        }

    }

}

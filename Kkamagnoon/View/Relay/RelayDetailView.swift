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
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }
    }

    func setCollectionView() {
        self.addSubview(relayWritingList)

        relayWritingList.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(15.0)
            $0.width.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()

        }

//        Observable.just([SectionModel(model: "title", items: ["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])])
//            .bind(to: relayWritingList.collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)

    }

}

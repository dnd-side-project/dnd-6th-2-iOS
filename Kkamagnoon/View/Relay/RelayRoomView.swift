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

class RelayRoomView: UIView {

    var categoryFilterView = TagListView()

    var sortButton = UIButton()
        .then {
            $0.setTitle("인기순", for: .normal)
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            $0.sizeToFit()
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 12)
        }

    var relayList = ArticleListView()
        .then {
            $0.collectionView.register(RelayRoomCell.self, forCellWithReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier)
        }

    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(categoryFilterView)
        categoryFilterView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalToSuperview()
            $0.height.equalTo(29.0)
        }

        self.addSubview(sortButton)
        sortButton.snp.makeConstraints {
            $0.top.equalTo(categoryFilterView.snp.bottom).offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        self.addSubview(relayList)
        relayList.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(sortButton.snp.bottom).offset(11.83)
        }

        // DUMMY
        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        dummyData.bind(to: relayList.collectionView
                        .rx.items(cellIdentifier: RelayRoomCell.relayRoomCellIdentifier,
                                             cellType: RelayRoomCell.self)) { (_, element, cell) in
            cell.contentLabel.text = element
            cell.layer.cornerRadius = 15
            }
        .disposed(by: disposeBag)
    }

}

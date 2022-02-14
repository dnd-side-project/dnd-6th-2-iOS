//
//  RelayRoomView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import Then
import SnapKit

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
            $0.backgroundColor = .brown
            $0.collectionView.register(RelayRoomCell.self, forCellWithReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier)
        }

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
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(29.0)
        }

        self.addSubview(sortButton)
        sortButton.snp.makeConstraints {
            $0.top.equalTo(categoryFilterView.snp.bottom).offset(20.0)
            $0.right.equalToSuperview()
        }

        self.addSubview(relayList)
        relayList.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(sortButton.snp.bottom).offset(11.83)
        }
    }

}

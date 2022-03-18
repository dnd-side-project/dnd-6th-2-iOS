//
//  ParticipatedRoomView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import UIKit
import Then
import SnapKit

class ParticipatedRoomView: UIView {
    var relayList = ArticleListView()
        .then {
            $0.collectionView.register(RelayRoomCell.self, forCellWithReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
}

extension ParticipatedRoomView {
    func setView() {
        self.addSubview(relayList)

        relayList.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.top.equalToSuperview()
        }
    }
}

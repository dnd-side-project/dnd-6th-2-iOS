//
//  MyWritingCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/23.
//

import UIKit
import Then

class MyWritingCell: UICollectionViewCell {

    static let identifier = "MyWritingCellIdentifier"

    var card = MyChallengeCard()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15.0
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(card)
        card.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

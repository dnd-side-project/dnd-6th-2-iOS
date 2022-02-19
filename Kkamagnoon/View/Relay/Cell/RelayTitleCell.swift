//
//  RelayTitleCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import Then
import SnapKit

class RelayTitleCell: UICollectionViewCell {

    static let relayTitleCellIdentifier = "RelayTitleCellIdentifier"

    var titleLabel: UILabel = UILabel()
        .then {
            // Dummy
            $0.text = "첫사랑"
            $0.font = UIFont.pretendard(weight: .bold, size: 25)
            $0.textColor = .white
        }

    var totalCountLabel = UILabel()
        .then {
            // DUMMY
            $0.text = "총 5편"
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .medium, size: 14)
        }

    var contributedListLabel = UILabel()
        .then {

            $0.text = "무시무시한,무시무시한,무시무시한,무시무시한,무시무시한,무시무시한 지음"
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)

        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(29.0)
            $0.top.equalToSuperview().offset(92.0)
        }

        self.addSubview(totalCountLabel)
        totalCountLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(46.0)
        }

        self.addSubview(contributedListLabel)
        contributedListLabel.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 98.0)
            $0.left.equalTo(titleLabel)
            $0.right.equalToSuperview().offset(-29.0)
            $0.top.equalTo(totalCountLabel.snp.bottom).offset(15.0)
            // TEMP
            $0.bottom.equalToSuperview().offset(-30.0)
        }
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)

        let size = self.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }
}

//
//  RelayContentCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import Then
import SnapKit

class RelayContentCell: UICollectionViewCell {

    static let relayContentCellIdentifier = "RelayContentCellIdentifier"

    var subTitleLabel: UILabel = UILabel()
        .then {
            // Dummy
            $0.text = "언젠가는"
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .semibold, size: 17.478)
        }

    var moreButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "More"), for: .normal)
        }

//    var contentTextView = UITextView()
//        .then {
//            $0.setTextWithLineHeight(
//                // Dummy
//                text: StringType.dummyContents,
//                lineHeight: 24,
//                fontSize: 15.7032,
//                fontWeight: .regular,
//                color: .white
//            )
//
//            $0.backgroundColor = UIColor(rgb: Color.feedListCard)
//            $0.isScrollEnabled = false
//            $0.isEditable = false
//            $0.isSelectable = false
//            $0.isUserInteractionEnabled = false
//            $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }

    var contentTextLabel = UILabel()
        .then {
            $0.text = "더미더미"

            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.setTextWithLineHeight(text: $0.text, lineHeight: Numbers(rawValue: 24) ?? .lineheightInBox)

            $0.backgroundColor = UIColor(rgb: Color.feedListCard)
        }

    var writerLabel = UILabel()
        .then {
            // Dummy
            $0.text = "아더에러 지음"
            $0.textColor = UIColor(rgb: 0xADADAD)
            $0.font = UIFont.pretendard(weight: .medium, size: 12)
        }

    var updateDate = UILabel()
        .then {
            // Dummy
            $0.text = "2022년 2월 1일"
            $0.font = UIFont.pretendard(weight: .regular, size: 12)
            $0.textColor = UIColor(rgb: 0x626262)
        }

    var pageLabel = UILabel()
        .then {
            // DUMMY
            $0.text = "1"
            $0.font = UIFont.pretendard(weight: .regular, size: 12)
            $0.textColor = UIColor(rgb: 0xADADAD)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        self.layer.cornerRadius = 15.0
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(42.63)
            $0.left.equalToSuperview().offset(31.0)
        }

        self.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-21.5)
            $0.top.equalTo(subTitleLabel)
        }

        self.addSubview(contentTextLabel)
        contentTextLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(17.89)
            $0.left.equalTo(subTitleLabel)
        }

        self.addSubview(writerLabel)
        writerLabel.snp.makeConstraints {
            $0.left.equalTo(subTitleLabel)
            $0.top.equalTo(contentTextLabel.snp.bottom).offset(90.43)
        }

        self.addSubview(updateDate)
        updateDate.snp.makeConstraints {
            $0.left.equalTo(subTitleLabel)
            $0.top.equalTo(writerLabel.snp.bottom).offset(5.0)
            $0.bottom.equalToSuperview().offset(-23.0)
        }

        self.addSubview(pageLabel)
        pageLabel.snp.makeConstraints {
            $0.centerY.equalTo(updateDate)
            $0.right.equalToSuperview().offset(-23.0)
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

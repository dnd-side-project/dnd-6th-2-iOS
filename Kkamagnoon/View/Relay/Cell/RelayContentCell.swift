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

    var moreButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "More2"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
        }

    var contentTextLabel = UILabel()
        .then {
            $0.text = "더미더미"
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .regular, size: 15.73)
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

    var likeButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Heart2"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
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
        super.init(coder: coder)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        self.layer.cornerRadius = 15.0
        setView()
    }

    func setView() {

        self.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-21.5)
            $0.top.equalToSuperview().offset(30)
            $0.size.equalTo(15.73)
        }

        self.addSubview(contentTextLabel)
        contentTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28.0)
            $0.left.equalToSuperview().offset(28.0)
        }

        self.addSubview(writerLabel)
        writerLabel.snp.makeConstraints {
            $0.left.equalTo(contentTextLabel)
            $0.top.equalTo(contentTextLabel.snp.bottom).offset(90.43)
        }

        self.addSubview(updateDate)
        updateDate.snp.makeConstraints {
            $0.left.equalTo(contentTextLabel)
            $0.top.equalTo(writerLabel.snp.bottom).offset(5.0)
        }

        self.addSubview(likeButton)
        likeButton.snp.makeConstraints {
            $0.top.equalTo(updateDate.snp.bottom).offset(28.0)
            $0.left.equalTo(updateDate)
            $0.bottom.equalToSuperview().offset(-32.55)
            $0.size.equalTo(23.0)
        }

        self.addSubview(pageLabel)
        pageLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-25.0)
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

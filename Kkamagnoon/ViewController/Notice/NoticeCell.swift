//
//  NoticeCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import UIKit
import Then
import SnapKit

class NoticeCell: UICollectionViewCell {

    static let identifier = "NoticeCellIdentifier"

    let textLabel = UILabel()
        .then {
            $0.text = "팔로우 했습니다."
            $0.textColor = UIColor(rgb: 0xEFEFEF)
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x1E1E1E)
        self.layer.cornerRadius = 15
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(rgb: 0x1E1E1E)
        self.layer.cornerRadius = 15
        setView()
    }

    func setView() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(16.0)
            $0.bottom.right.equalToSuperview().offset(-16.0)
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

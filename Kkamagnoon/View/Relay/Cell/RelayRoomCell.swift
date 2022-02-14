//
//  RelayRoomCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import SnapKit
import Then

class RelayRoomCell: UICollectionViewCell {
    static let relayRoomCellIdentifier = "RelayRoomCellIdentifier"

    var profileView = ProfileView(width: 28, height: 28, fontsize: 14)
        .then {
            $0.nickNameLabel.font = UIFont.pretendard(weight: .semibold, size: 14)
        }

    var contentLabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.lineBreakMode = .byTruncatingTail
        }

    var tagListView = TagListMultiLineView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14.0)
            $0.left.equalToSuperview().offset(16.0)
        }

        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16.0)
            $0.right.equalToSuperview().offset(-16.0)
            $0.top.equalTo(profileView.snp.bottom).offset(17.0)
        }

        self.addSubview(tagListView)
        tagListView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16.0)
            $0.top.equalTo(contentLabel.snp.bottom).offset(27.0)
            $0.right.equalToSuperview().offset(-90.0)
            $0.bottom.equalToSuperview().offset(-16.42)
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()

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

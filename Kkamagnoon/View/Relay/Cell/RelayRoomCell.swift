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
            $0.nickNameLabel.lineBreakMode = .byTruncatingTail
            $0.nickNameLabel.font = UIFont.pretendard(weight: .semibold, size: 14)
            $0.nickNameLabel.text = "첫사랑"
            $0.subscribeStatus.isHidden = true
        }

    var contentLabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.text = "첫사랑과 관련한 로맨스를 쓰고싶어서 만들었어요!"
            $0.textColor = .white
            $0.lineBreakMode = .byTruncatingTail
        }

    var tagListView = MultiLineTagListView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        setView()
    }

    var personnelLabel = ImageLabelView()
        .then {
            $0.labelView.text = "1/6"
            $0.labelView.font = UIFont.pretendard(weight: .bold, size: 11.61)
            $0.labelView.textColor = .white
            $0.imageView.image = UIImage(named: "LeftCharacter")
            $0.imageView.contentMode = .scaleAspectFit
            $0.imageView.snp.makeConstraints { make in
                make.width.equalTo(33)
                make.height.equalTo(22)
            }
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14.0)
            $0.left.equalToSuperview().offset(16.0)
            $0.right.equalToSuperview().offset(-16.0)
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

        self.addSubview(personnelLabel)
        personnelLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview().offset(-20.0)
        }

        personnelLabel.labelView.snp.makeConstraints {
            $0.left.equalTo(personnelLabel.imageView.snp.right).offset(8.0)
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        tagListView.removeTags()
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
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

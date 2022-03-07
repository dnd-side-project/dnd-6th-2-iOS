//
//  AddingTagCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/24.
//

import UIKit
import Then
import SnapKit

class AddingTagCell: UICollectionViewCell {
    static let identifier = "AddingTagCellIdentifier"

    let tagView = TagView(top: 10, bottom: -10, leading: 16, trailing: -16)
        .then {
            $0.categoryLabel.font = UIFont.pretendard(weight: .semibold, size: 12)
            $0.layer.cornerRadius = 18
            $0.backgroundColor = UIColor(rgb: Color.tagGreen)
            $0.categoryLabel.textColor = .white
            $0.categoryLabel.lineBreakMode = .byWordWrapping
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(tagView)

        tagView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes {

        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        let size = tagView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame

        return layoutAttributes
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        tagView.categoryLabel.text = nil
        tagView.backgroundColor = UIColor(rgb: Color.tagGreen)
    }

}

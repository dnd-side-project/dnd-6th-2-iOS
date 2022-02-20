//
//  SelectingTagCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit

class SelectingTagCell: UICollectionViewCell {

    static let selectingTagCellIdentifier = "SelectingTagCellIdentifier"

    let tagView = TagView(top: 10, bottom: -10, leading: 69, trailing: -69)
        .then {
            $0.categoryLabel.font = UIFont.pretendard(weight: .semibold, size: 16)
            $0.categoryLabel.textColor = .white

            $0.backgroundColor = .red
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView(top: 10, bottom: -10, leading: 69, trailing: -69)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView(top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
        self.addSubview(tagView)

        tagView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(top)
            $0.leading.equalToSuperview().offset(leading)
            $0.trailing.equalToSuperview().offset(trailing)
            $0.bottom.equalToSuperview().offset(bottom)
        }
    }
}

//
//  TagView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import UIKit
import Then
import SnapKit

class TagView: UIView {
    var categoryLabel: UILabel = UILabel()
        .then {
            $0.textColor = UIColor(rgb: Color.tagText)
            $0.font = UIFont.pretendard(weight: .medium, size: 12)
        }

    init(top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {

        super.init(frame: .zero)
        self.backgroundColor = UIColor(rgb: Color.tag)
        self.layer.cornerRadius = 18.0
        setView(top: top, bottom: bottom, leading: leading, trailing: trailing)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView(top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
        self.addSubview(categoryLabel)

        categoryLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(trailing)
            $0.leading.equalToSuperview().offset(leading)
            $0.top.equalToSuperview().offset(top)
            $0.bottom.equalToSuperview().offset(bottom)
        }
    }
}

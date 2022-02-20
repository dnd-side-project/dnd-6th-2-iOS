//
//  PairView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit

class PairView: UIView {

    var stackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 9
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }

    var firstTag = TagView(top: 17, bottom: -17, leading: 0, trailing: 0)
        .then {
            $0.categoryLabel.font = UIFont.pretendard(weight: .semibold, size: 16)
            $0.categoryLabel.textColor = .white
            $0.backgroundColor = UIColor(rgb: 0x292929)
            $0.layer.cornerRadius = 26.5
            $0.snp.makeConstraints { obj in
                obj.width.equalTo((UIScreen.main.bounds.width - 49) / 2)
            }
        }

    var secondTag = TagView(top: 17, bottom: -17, leading: 0, trailing: 0)
        .then {
            $0.categoryLabel.font = UIFont.pretendard(weight: .semibold, size: 16)
            $0.categoryLabel.textColor = .white
            $0.backgroundColor = UIColor(rgb: 0x292929)
            $0.layer.cornerRadius = 26.5
            $0.snp.makeConstraints { obj in
                obj.width.equalTo((UIScreen.main.bounds.width - 49) / 2)
            }
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(stackView)

        stackView.addArrangedSubview(firstTag)
        stackView.addArrangedSubview(secondTag)

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

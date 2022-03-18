//
//  SettingPersonnelView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/19.
//

import UIKit
import Then
import SnapKit
import RxSwift

class SettingPersonnelView: UIView {

    let minusButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x333333)
            $0.setTitle("-", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .regular, size: 25.0)
        }

    let plusButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x333333)
            $0.setTitle("+", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .regular, size: 25.0)
        }

    let personnelLabel = UILabel()
        .then {
            $0.text = "0명"
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.textColor = .white
        }

    override func layoutSubviews() {
        super.layoutSubviews()
        minusButton.roundCorners(corners: [.topLeft, .bottomLeft], radius: 11.0)
        plusButton.roundCorners(corners: [.topRight, .bottomRight], radius: 11.0)

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 11.0
        self.backgroundColor = UIColor(rgb: Color.tag)

        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 11.0
        self.backgroundColor = UIColor(rgb: Color.tag)

        setView()
    }

    func setView() {
        self.addSubview(personnelLabel)
        personnelLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        self.addSubview(minusButton)
        minusButton.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(45.5)
        }

        self.addSubview(plusButton)
        plusButton.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo(45.5)
        }
    }

}

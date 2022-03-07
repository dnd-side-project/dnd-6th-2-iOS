//
//  NextButton.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/25.
//

import UIKit
import Then
import SnapKit

class NextButton: UIButton {

    var textLabel = UILabel()
        .then {
            $0.text = "다음"
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .semibold, size: 14)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 18
        self.backgroundColor = UIColor(rgb: Color.whitePurple)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NextButton {
    func setView() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(57)
            $0.height.equalTo(25)
        }
    }
}

//
//  ChallengeHeaderView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/20.
//

import UIKit
import Then
import SnapKit

class ChallengeHeaderView: UIView {

    var titleLabel = UILabel()
        .then {
            $0.text = "챌린지"
            $0.font = UIFont.pretendard(weight: .semibold, size: 26)
            $0.textColor = .white
        }

    var bellButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.top.equalToSuperview().offset(22.0)
            $0.bottom.equalToSuperview().offset(-8.0)
        }

        self.addSubview(bellButton)
        bellButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-17.0)
            $0.centerY.equalTo(titleLabel)
        }
    }
}

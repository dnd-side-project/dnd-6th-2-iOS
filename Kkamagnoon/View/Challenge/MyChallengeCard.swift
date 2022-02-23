//
//  MyChallengeCard.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/20.
//
import UIKit
import Then
import SnapKit

class MyChallengeCard: UIView {

    var titleLabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(weight: .semibold, size: 14)
            $0.textColor = .white
            // TEMP
            $0.text = "거울"
        }

    var grayLine = GrayBorderView()

    var contentLabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(weight: .regular, size: 13)
            $0.textColor = UIColor(rgb: 0xEAEAEA)

            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.setTextWithLineHeight(
                text: "거울은 나를 비춰주는 물건이다. 거울을 멍하니 바라보면 내가 누구인지 조금은 알 것 같은 기분이다.",
                lineHeight: .lineheightInBox)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x1E1E1E)
        self.layer.cornerRadius = 15
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.left.equalToSuperview().offset(20.0)

        }

        self.addSubview(grayLine)
        grayLine.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(grayLine.snp.bottom).offset(11.0)
        }
    }

}

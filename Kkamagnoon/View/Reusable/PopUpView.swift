//
//  PopUpView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import Then
import SnapKit

class PopUpView: UIView {

    var alertTitleLabel = UILabel()
        .then {
            $0.text = "안내사항"
            $0.font = UIFont.pretendard(weight: .bold, size: 19.2208)
            $0.textColor = UIColor(rgb: 0xF9F9F9)
        }

    var contentLabel = UILabel()
        .then {
            $0.text = "주제에 맞지 않는 글을 쓰거나 욕설 또는 비방을 할 경우에는 강퇴, 정지 될 수 있습니다."
            $0.font = UIFont.pretendard(weight: .medium, size: 14.4156)
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.textColor = UIColor(rgb: 0xE6E6E6)
            $0.lineBreakMode = .byWordWrapping
        }

    var subContentLabel = UILabel()
        .then {
            $0.text = "*자세한 안내는 공지사항을 눌러 확인해주세요."
            $0.font = UIFont.pretendard(weight: .regular, size: 10)
            $0.textColor = UIColor(rgb: 0xC8C8C8)
        }

    var stackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 7
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }

    var exitButton = UIButton()
        .then {
            $0.setTitle("나가기", for: .normal)
            $0.setTitleColor(UIColor(rgb: Color.whitePurple), for: .normal)
            $0.backgroundColor = UIColor(rgb: 0x696969)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 14.4156)
            $0.layer.cornerRadius = 6.72
        }

    var enterButton = UIButton()
        .then {
            $0.setTitle("입장하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 14.4156)
            $0.layer.cornerRadius = 6.72
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 14.41
        self.backgroundColor = UIColor(rgb: 0x3F3F3F)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(alertTitleLabel)
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(75.0)
            $0.centerX.equalToSuperview()
        }

        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(262.0)
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(8.94)
        }

        self.addSubview(subContentLabel)
        subContentLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(3.0)
            $0.centerX.equalToSuperview()
        }

        self.addSubview(stackView)
        stackView.addArrangedSubview(exitButton)
        stackView.addArrangedSubview(enterButton)

        stackView.snp.makeConstraints {
            $0.top.equalTo(subContentLabel.snp.bottom).offset(16.0)
            $0.left.equalToSuperview().offset(16.0)
            $0.right.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-17.0)
            $0.height.equalTo(44.0)
        }
    }

}

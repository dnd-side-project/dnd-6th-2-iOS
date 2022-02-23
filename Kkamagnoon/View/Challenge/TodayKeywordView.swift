//
//  TodayKeywordView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/20.
//
import UIKit
import Then
import SnapKit

class TodayKeywordView: UIView {

    var subLabel = UILabel()
        .then {
            $0.text = "오늘의 키워드는..."
            $0.textColor = UIColor(rgb: 0xEAEAEA)
            $0.font = UIFont.pretendard(weight: .regular, size: 16)
        }

    var keywordLabel = UILabel()
        .then {
            $0.text = "거울"
            $0.textColor = UIColor(rgb: Color.tagGreen)
            $0.font = UIFont.pretendard(weight: .bold, size: 38)
        }

    var goToFeedButotn = UIButton()
        .then {
            $0.layer.cornerRadius = 30
            $0.backgroundColor = UIColor(rgb: 0x262626)
            $0.setTitle("다른사람의 글 보러가기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .semibold, size: 14)
        }

    // TODO: 일러스트 넣기
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x1A1A1A)
        self.layer.cornerRadius = 14

        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TodayKeywordView {
    func setView() {
        self.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.top.equalToSuperview().offset(29.68)
        }

        self.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints {
            $0.left.equalTo(subLabel)
            $0.top.equalTo(subLabel.snp.bottom).offset(8.0)
        }

        self.addSubview(goToFeedButotn)
        goToFeedButotn.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(17.32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width * 184/350)
            $0.height.equalTo(41.0)
            $0.bottom.equalToSuperview().offset(-23.0)
        }
    }
}

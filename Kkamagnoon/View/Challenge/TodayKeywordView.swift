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

    var goToFeedButton = UIButton()
        .then {
            $0.layer.cornerRadius = 30
            $0.backgroundColor = UIColor(rgb: 0x262626)
            $0.setTitle("다른사람의 글 보러가기", for: .normal)
            $0.setImage(UIImage(named: "GoRight"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
            $0.imageEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
            $0.semanticContentAttribute = .forceRightToLeft
            $0.titleLabel?.font = UIFont.pretendard(weight: .semibold, size: 14)
        }

    var imageView = UIImageView()
        .then {
            $0.image = UIImage(named: "Note")
            $0.contentMode = .scaleAspectFit
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        layoutView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        layoutView()
    }

}

extension TodayKeywordView {
    func configureView() {

//        self.backgroundColor = UIColor(rgb: 0x1A1A1A)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        self.layer.cornerRadius = 14

    }

    func layoutView() {
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

        self.addSubview(goToFeedButton)
        goToFeedButton.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(17.32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width * 184/350)
            $0.height.equalTo(41.0)
            $0.bottom.equalToSuperview().offset(-23.0)
        }

        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-15.26)
            $0.top.equalToSuperview().offset(24.0)
            $0.width.equalTo(69.74)
            $0.height.equalTo(76.37)
        }
    }
}

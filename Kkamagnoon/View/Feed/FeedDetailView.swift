//
//  DetailView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import UIKit
import RxSwift
import SnapKit
import Then

class FeedDetailView: UIView {

    lazy var profileView = ProfileView(width: 42, height: 42, fontsize: 15)

    lazy var moreButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "More"), for: .normal)
        }

    lazy var updateDateLabel = UILabel()
        .then {
            $0.text = "2022년 2월 1일"
            $0.font = UIFont.pretendard(weight: .regular, size: 12)
            $0.textColor = UIColor(rgb: 0x626262)
        }

    lazy var titleLabel: UILabel = UILabel()
        .then {
            $0.textColor = .white
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont.pretendard(weight: .semibold, size: 20)
            // DUMMY
            $0.text = "언젠가는"
        }

    lazy var contentLabel: UILabel = UILabel()
        .then {
            $0.setTextWithLineHeight(text: StringType.dummyContents, lineHeight: .lineheightInBox)
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .regular, size: 18.0)
//            $0.setTextWithLineHeight(text: StringType.dummyContents, lineHeight: 27, fontSize: 18.0, fontWeight: .regular, color: .white)

        }

    var tagListView: TagListView = TagListView()

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProfileVeiw()
        setMoreButton()
        setUpdateDateLabel()
        setTitleLabel()
        setContentLabel()
        setTagListView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setProfileVeiw()
        setMoreButton()
        setUpdateDateLabel()
        setTitleLabel()
        setContentLabel()
        setTagListView()
    }

    func setProfileVeiw() {
        self.addSubview(profileView)

        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26.0)
            $0.left.equalToSuperview()
        }
    }

    func setMoreButton() {
        self.addSubview(moreButton)

        moreButton.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.right.equalToSuperview().offset(-4.0)
            $0.centerY.equalTo(profileView)
        }
    }

    func setUpdateDateLabel() {
        self.addSubview(updateDateLabel)

        updateDateLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(profileView.snp.bottom).offset(14.0)
        }
    }

    func setTitleLabel() {

        self.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(updateDateLabel.snp.bottom).offset(17.0)
            $0.left.right.equalToSuperview()
        }
    }

    func setContentLabel() {

        self.addSubview(contentLabel)

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(21.0)
            $0.width.equalToSuperview()
            $0.left.right.equalToSuperview()
        }

    }

    func setTagListView() {

        self.addSubview(tagListView)

        tagListView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(74.0)
            $0.bottom.equalToSuperview().offset(-15.0)
            $0.height.equalTo(30.0)
        }
    }
}

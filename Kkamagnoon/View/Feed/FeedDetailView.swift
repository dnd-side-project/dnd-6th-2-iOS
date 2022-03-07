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
            $0.font = UIFont.pretendard(weight: .semibold, size: 20)
            // DUMMY
            $0.text = "언젠가는"
        }

    lazy var contentTextView: UITextView = UITextView()
        .then {
            $0.setTextWithLineHeight(text: StringType.dummyContents, lineHeight: 27, fontSize: 18.0, fontWeight: .regular, color: .white)
            $0.isEditable = false
            $0.isUserInteractionEnabled = false
            $0.backgroundColor = UIColor(rgb: Color.basicBackground)
            $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.isScrollEnabled = false
            $0.sizeToFit()

        }

    var tagListView: TagListView?

    let disposeBag = DisposeBag()

    init(frame: CGRect, tags: [String]) {
        super.init(frame: frame)
        setProfileVeiw()
        setMoreButton()
        setUpdateDateLabel()
        setTitleLabel()
        setContentTextView()
        setTagListView(tags: tags)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    func setContentTextView() {

        self.addSubview(contentTextView)

        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(21.0)
            $0.width.equalToSuperview()
            $0.left.right.equalToSuperview()
        }

    }

    func setTagListView(tags: [String]) {

        tagListView = TagListView(frame: .zero, tags: tags)
        tagListView?.filterView.allowsSelection = false

        guard let tagListView = tagListView else {
            return
        }

        self.addSubview(tagListView)

        tagListView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(contentTextView.snp.bottom).offset(74.0)
            $0.bottom.equalToSuperview().offset(-15.0)
            $0.height.equalTo(30.0)
        }
    }
}

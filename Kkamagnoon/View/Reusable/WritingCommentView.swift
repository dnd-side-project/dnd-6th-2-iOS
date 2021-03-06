//
//  WritingCommentView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//

import UIKit
import SnapKit
import RxSwift

class WritingCommentView: UIView {

    let grayLine: GrayBorderView = GrayBorderView()
    let profileImageView: UIImageView = UIImageView()
    let textView: UITextView = UITextView()
    let postingButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        setGrayLine()
        setProfileImageView()
        setTextView()
        setPostingButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        setGrayLine()
        setProfileImageView()
        setTextView()
        setPostingButton()
    }

    override func layoutSubviews() {
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        }
    }

    func setGrayLine() {
        self.addSubview(grayLine)

        grayLine.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(-0.5)
        }
    }

    func setProfileImageView() {
        profileImageView.backgroundColor = .white
        self.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 21).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.5).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 29).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 29).isActive = true
    }

    func setTextView() {
        // Dummy
        textView.text = "댓글달기"
        textView.backgroundColor = UIColor(rgb: Color.feedListCard)
        textView.textColor = UIColor(rgb: Color.placeholder)
        textView.isScrollEnabled = false
        self.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16).isActive = true
        textView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true

        let disposeBag = DisposeBag()

        textView.rx.didBeginEditing
            .withUnretained(self)
            .bind { owner, _ in
                if owner.textView.textColor == UIColor(rgb: Color.placeholder) {
                    owner.textView.text = nil
                    owner.textView.textColor = UIColor.white
                }

            }
            .disposed(by: disposeBag)

        textView.rx.didEndEditing
            .withUnretained(self)
            .bind { owner, _ in
                if owner.textView.text.isEmpty {
                    owner.textView.text = "댓글달기"
                    owner.textView.textColor = UIColor(rgb: Color.placeholder)
                }
            }
            .disposed(by: disposeBag)
    }

    func setPostingButton() {
        self.addSubview(postingButton)
        postingButton.translatesAutoresizingMaskIntoConstraints = false

        postingButton.setTitle("게시", for: .normal)
        postingButton.titleLabel?.font = UIFont.pretendard(weight: .semibold, size: 14)

        postingButton.setTitleColor(UIColor(rgb: Color.tag), for: .normal)

        postingButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        postingButton.leftAnchor.constraint(equalTo: textView.rightAnchor, constant: 16).isActive = true
        postingButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -34).isActive = true
        postingButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
    }

}

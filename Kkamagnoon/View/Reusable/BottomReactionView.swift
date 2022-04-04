//
//  BottomReactionView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/09.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

class BottomReactionView: UIView {

    lazy var grayLine: GrayBorderView = GrayBorderView()

    lazy var likeButton: UIButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Heart")?.resizedImage(size: CGSize(width: 32.0, height: 32.0)), for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .regular, size: 16)
        }

    lazy var commentButton: UIButton = UIButton()
        .then {
            $0.imageView?.contentMode = .scaleAspectFit

            $0.setImage(UIImage(named: "Comment")?.resizedImage(size: CGSize(width: 32.0, height: 32.0)), for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .regular, size: 16)
        }

    lazy var bookmarkButton: UIButton = UIButton()
        .then {
            $0.imageView?.contentMode = .scaleAspectFit

            $0.setImage(UIImage(named: "Bookmark")?.resizedImage(size: CGSize(width: 28.0, height: 28.0)), for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .regular, size: 16)

        }

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        self.addSubview(grayLine)
        grayLine.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(-0.5)
        }

        self.addSubview(likeButton)

        likeButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.top.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview()

        }

        self.addSubview(commentButton)

        commentButton.snp.makeConstraints {
            $0.left.equalTo(likeButton.snp.right).offset(23.0)
            $0.centerY.equalTo(likeButton)

        }

        self.addSubview(bookmarkButton)

        bookmarkButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-23.0)
            $0.centerY.equalTo(likeButton)

        }

    }

}

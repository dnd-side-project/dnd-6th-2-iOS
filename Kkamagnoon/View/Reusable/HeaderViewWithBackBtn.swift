//
//  RelayRoomHeaderView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import UIKit
import RxSwift
import RxCocoa

class HeaderViewWithBackBtn: UIView {

    var disposeBag = DisposeBag()

    let backButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Back"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 18)
        }

    let titleLabel = UILabel()
        .then {
            $0.text = StringType.relayRoom
            $0.font = UIFont.pretendard(weight: .semibold, size: 20)
            $0.textColor = .white
        }

    let bellButton = UIButton()

    var noticeButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setBackButton()
        setTitleLabel()
        setNoticeButton()
        setBellButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setBackButton()
        setTitleLabel()
        setNoticeButton()
        setBellButton()
    }

    func setBackButton() {

        self.addSubview(backButton)

        backButton.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.left.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(26.24)
        }

        // MOVE
        backButton.rx.tap
            .bind { _ in
                self.viewController?.navigationController?.popViewController(animated: true)

            }
            .disposed(by: disposeBag)
    }

    func setTitleLabel() {
        self.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.left.equalTo(backButton.snp.right).offset(16.88)
        }
    }

    func setNoticeButton() {
        self.addSubview(noticeButton)

        noticeButton.snp.makeConstraints {
//            $0.size.equalTo(28.0)
            $0.right.equalToSuperview()
            $0.centerY.equalTo(backButton)
        }
    }

    func setBellButton() {
        self.addSubview(bellButton)

        bellButton.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.right.equalTo(noticeButton.snp.left).offset(-11.0)
            $0.centerY.equalTo(backButton)
        }
    }
}

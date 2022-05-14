//
//  WritingView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/25.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class WritingView: UIView {

    var disposeBag = DisposeBag()

    var titleTextField = UITextField()
        .then {
            $0.placeholder = "제목을 써주세요"
            $0.textColor = .white
            $0.setPlaceholderColor(UIColor(rgb: 0x929292))

            $0.font = UIFont.pretendard(weight: .semibold, size: 20)
            $0.borderStyle = .none
        }

    var grayLine = GrayBorderView()

    var contentTextView = UITextView()
        .then {
            $0.text = "내용을 자유롭게 써주세요"
            $0.textAlignment = .left
            $0.textColor = UIColor(rgb: 0x929292)
            $0.font = UIFont.pretendard(weight: .regular, size: 18)
            $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        bindView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
        bindView()
    }

}

extension WritingView {
    func setView() {
        self.addSubview(titleTextField)
        titleTextField.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }

        self.addSubview(grayLine)
        grayLine.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(16.0)
            $0.left.right.equalToSuperview()
        }

        self.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(grayLine).offset(40.0)
            $0.left.right.bottom.equalToSuperview()
        }
    }

    func bindView() {
        contentTextView.rx.didBeginEditing
            .withUnretained(self)
            .bind { owner, _ in
                if owner.contentTextView.textColor == UIColor(rgb: 0x929292) {
                owner.contentTextView.text = nil
                owner.contentTextView.textColor = UIColor.white
                }
            }
            .disposed(by: disposeBag)

        contentTextView.rx.didEndEditing
            .withUnretained(self)
            .bind { owner, _ in
                if owner.contentTextView.text.isEmpty {
                    owner.contentTextView.text = "내용을 자유롭게 써주세요"
                    owner.contentTextView.textColor = UIColor(rgb: 0x929292)
                }
            }
            .disposed(by: disposeBag)
    }
}

//
//  ShortTextView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import RxSwift
import RxCocoa

class ShortTextView: UITextView {

    var disposeBag = DisposeBag()

    init(frame: CGRect, textContainer: NSTextContainer?, placeholder: String) {
        super.init(frame: frame, textContainer: textContainer)
        setView(placeholder: placeholder)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setView(placeholder: placeholder)
    }

    func setView(placeholder: String) {
        self.backgroundColor = UIColor(rgb: Color.tag)
        self.text = placeholder
        self.textColor = UIColor(rgb: Color.placeholder)
        self.font = UIFont.pretendard(weight: .regular, size: 14)
        self.layer.cornerRadius = 15.0

        self.textContainerInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)

        self.rx.didBeginEditing
            .withUnretained(self)
            .bind { owner, _ in
                if owner.textColor == UIColor(rgb: Color.placeholder) {
                    owner.text = nil
                    owner.textColor = UIColor.white
                        }

            }
            .disposed(by: disposeBag)

        self.rx.didEndEditing
            .withUnretained(self)
            .bind { owner, _ in
                if owner.text.isEmpty {
                    owner.text = placeholder
                    owner.textColor = UIColor(rgb: Color.placeholder)
                        }
            }
            .disposed(by: disposeBag)
    }
}

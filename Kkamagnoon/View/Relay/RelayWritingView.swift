//
//  RelayWritingView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/09.
//

import UIKit
import RxSwift

class RelayWritingView: UIView {

    var relayListStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 8.0
        }

    var contentTextView = UITextView()
        .then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.textContainer.lineBreakMode = .byWordWrapping
            $0.textContainer.maximumNumberOfLines = 0
            $0.textColor = UIColor(rgb: 0x929292)
            $0.font = UIFont.pretendard(weight: .regular, size: 18)
            $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

}

extension RelayWritingView {
    func setView() {
        self.addSubview(relayListStackView)
        relayListStackView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }

        self.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(relayListStackView.snp.bottom).offset(18.0)
            $0.left.right.bottom.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.greaterThanOrEqualTo(100)
        }
    }
}

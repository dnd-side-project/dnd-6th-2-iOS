//
//  WritingSubView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/25.
//

import UIKit
import Then
import SnapKit

class WritingSubView: UIView {

    var grayLine = GrayBorderView()

    var copyWritingButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Copy"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        }

    var alignButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "AlignLeft"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        }

    var showTipsButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Tip"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WritingSubView {
    func setView() {
        self.addSubview(grayLine)
        grayLine.snp.makeConstraints {

            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(-0.5)
        }

        self.addSubview(copyWritingButton)
        copyWritingButton.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20.0)
        }

        self.addSubview(alignButton)
        alignButton.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(copyWritingButton.snp.right).offset(30.0)
        }

        self.addSubview(showTipsButton)
        showTipsButton.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(alignButton.snp.right).offset(30.0)
        }
    }
}

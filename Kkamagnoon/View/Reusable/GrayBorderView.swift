//
//  GrayBorderView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import UIKit
import SnapKit
import Then

class GrayBorderView: UIView {

    let grayLine = UIView()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x545454)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(grayLine)

        grayLine.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.edges.equalToSuperview()
        }
    }

}

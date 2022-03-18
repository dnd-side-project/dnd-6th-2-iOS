//
//  ImageLabelView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import UIKit
import Then
import SnapKit

class ImageLabelView: UIView {

    let imageView = UIImageView()
    let labelView = UILabel().then {
        $0.font = UIFont.pretendard(weight: .regular, size: 13)
        $0.textColor = .white

        // DUMMY
        $0.text = "80"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        self.addSubview(imageView)
        self.addSubview(labelView)

        imageView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.size.equalTo(24.0)
        }

        labelView.snp.makeConstraints {
            $0.centerY.right.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).offset(4.0)
        }
    }

}

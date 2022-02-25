//
//  TipBox.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/25.
//

import UIKit
import Then
import SnapKit

class TipBox: UIView {

    var textLabel = UILabel()
        .then {
            $0.text = "글쓰기 팁에 관한 내용"
            $0.textColor = UIColor(rgb: 0x999999)
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 4
        self.backgroundColor = UIColor(rgb: 0x292929)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TipBox {
    func setView() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(12.0)
            $0.right.equalToSuperview().offset(-12.0)
        }
    }
}

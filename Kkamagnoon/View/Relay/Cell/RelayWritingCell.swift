//
//  RelayWritingCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/09.
//

import UIKit
import Then
import SnapKit

class RelayWritingCard: UIView {

    var contentLabel = UILabel()
        .then {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.textColor = UIColor(rgb: 0xE2E2E2)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension RelayWritingCard {
    func setView() {
        self.backgroundColor = UIColor(rgb: 0x212121)
        self.layer.cornerRadius = 15

        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview().offset(-16.0)
            $0.left.equalToSuperview().offset(27.0)
            $0.right.equalToSuperview().offset(-27.0)
        }
    }
}

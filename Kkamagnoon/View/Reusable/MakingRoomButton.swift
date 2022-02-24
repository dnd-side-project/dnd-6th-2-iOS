//
//  MakingRoomButton.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit

class MakingRoomButton: UIButton {

    var horizontalView = UIView()
        .then {
            $0.backgroundColor = .white
        }

    var verticalView = UIView()
        .then {
            $0.backgroundColor = .white
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MakingRoomButton {
    func setView() {
        self.addSubview(horizontalView)
        horizontalView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(21)
            $0.height.equalTo(3.23)
        }

        self.addSubview(verticalView)
        verticalView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(21)
            $0.width.equalTo(3.23)
        }
    }
}

//
//  SelectingCollectionReusableView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/19.
//

import UIKit

class SelectingCollectionReusableView: UICollectionReusableView {

    static let identifier = "SelectingCollectionReusableView"

    var titleLabel = UILabel()
        .then {
            $0.text = "글의 태그를\n선택 해주세요."
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont.pretendard(weight: .medium, size: 22)
            $0.textColor = .white
        }

    var subTitleLabel = UILabel()
        .then {
            $0.text = "피드를 볼 때 필터링에 사용 돼요."
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.textColor = UIColor(rgb: 0xB0B0B0)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(3.0)
            $0.right.equalToSuperview().offset(-3.0)
        }

        self.addSubview(subTitleLabel)

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7.0)
            $0.left.equalToSuperview().offset(3.0)
            $0.right.equalToSuperview().offset(-3.0)
            $0.bottom.equalToSuperview().offset(-28.0)
        }
    }

}

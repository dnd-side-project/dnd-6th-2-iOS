//
//  SearchTabMenuCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/19.
//

import UIKit
import Then

class SearchTabMenuCell: UICollectionViewCell {

    static let identifier = "SearchTabMenuCellIdentifier"

    var textLabel = UILabel()
        .then {
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .semibold, size: 16.0)
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

extension SearchTabMenuCell {
    func setView() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
}

//
//  SearchRecentTableViewCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/10.
//

import UIKit
import Then
import SnapKit

class SearchRecentTableViewCell: UITableViewCell {

    static let identifier = "SearchRecentTableViewCellIdentifier"

    var searchTextLabel = UILabel()
        .then {
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
            $0.textColor = UIColor(rgb: 0xE2E2E2)
            $0.font = UIFont.pretendard(weight: .regular, size: 18.0)
        }

    var xButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "CancelX"), for: .normal)
        }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

}

extension SearchRecentTableViewCell {
    func setView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none

        self.addSubview(searchTextLabel)
        searchTextLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().offset(12.0)
            $0.bottom.equalToSuperview().offset(-12.0)
            $0.right.equalToSuperview().offset(-30.0)
        }

        self.addSubview(xButton)
        xButton.snp.makeConstraints {
            $0.size.equalTo(20.0)
            $0.centerY.equalTo(searchTextLabel)
            $0.right.equalToSuperview()
        }
    }
}

//
//  SearchHistoryView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/19.
//

import UIKit
import Then
import SnapKit

class SearchHistoryView: UIView {

    var titleLabel = UILabel()
        .then {
            $0.text = "최근검색어"
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.textColor = UIColor(rgb: 0x767676)
        }

    var tableView = UITableView()
        .then {
            $0.backgroundColor = .clear
            $0.register(SearchRecentTableViewCell.self, forCellReuseIdentifier: SearchRecentTableViewCell.identifier)
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

extension SearchHistoryView {
    func setView() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33.0)
            $0.left.equalToSuperview().offset(20.0)
        }

        self.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }
    }
}

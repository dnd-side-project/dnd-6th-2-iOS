//
//  ParticipantListView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit

class ParticipantListView: UIView {

    let titleLabel = UILabel()
        .then {
            $0.text = "참여한 사람"
            $0.font = UIFont.pretendard(weight: .semibold, size: 20)
            $0.textColor = UIColor(rgb: 0xEFEFEF)

        }

    let tableView = UITableView()
        .then {
            $0.register(ParticipantCell.self, forCellReuseIdentifier: ParticipantCell.participantCellIdentifier)
        }

    let bottomView = BottomBar()
        .then {
            $0.frame.size.height = 70
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x2A2A2A)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(63.0)
            $0.left.equalToSuperview().offset(23.0)
            $0.right.equalToSuperview().offset(-23.0)
        }

        self.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(70.0)
        }

        tableView.backgroundColor = UIColor(rgb: 0x2A2A2A)
        self.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(26.0)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
        }
    }

}

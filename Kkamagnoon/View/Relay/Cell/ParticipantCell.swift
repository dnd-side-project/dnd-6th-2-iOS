//
//  ParticipantCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit

class ParticipantCell: UITableViewCell {

    static let participantCellIdentifier = "ParticipantCellIdentifier"

    let profileView = ProfileView(width: 42, height: 42, fontsize: 14)
        .then {
            $0.nickNameLabel.font = UIFont.pretendard(weight: .medium, size: 14)
            $0.subscribeStatus.isHidden = true
        }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(rgb: 0x2A2A2A)
        self.selectionStyle = .none
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(rgb: 0x2A2A2A)
        self.selectionStyle = .none
        setView()

    }

    func setView() {
        self.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9.0)
            $0.bottom.equalToSuperview().offset(-9.0)
            $0.left.equalToSuperview().offset(28.0)
            $0.right.equalToSuperview().offset(-28.0)
        }
    }

}

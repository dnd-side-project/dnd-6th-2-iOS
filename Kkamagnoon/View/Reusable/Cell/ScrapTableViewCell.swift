//
//  ScrapTableViewCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/05/18.
//

import UIKit
import SnapKit
import Then

class ScrapTableViewCell: UITableViewCell {

    static let identifier = "ScrapTableViewCellIdentifier"

    let categoryLabel = UILabel()
        .then {
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .regular, size: 15.0)
        }

    let checkButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
        }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {

        }
    }

    func layoutView() {

    }

}

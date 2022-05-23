//
//  ScrapBottomView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/05/18.
//

import UIKit
import SnapKit
import Then

class ScrapBottomView: UIView {

    let bottomView = UIView()
        .then {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.scrapBoxGray)
        }

    let titleIcon = UIImageView()
        .then {
            $0.image = UIImage(systemName: "heart.fill")
        }

    let titleLabel = UILabel()
        .then {
            $0.text = "스크랩 저장하기"
            $0.font = UIFont.pretendard(weight: .semibold, size: 15.0)
            $0.textColor = UIColor.appColor(.gray_1)
        }

//    let tableView = UITableView()
//        .then {
//            $0.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
//        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutView()
    }

}

extension ScrapBottomView {
    func layoutView() {
//        self.addSubview(bottomView)
//        bottomView.snp.makeConstraints {
//            
//        }
    }
}

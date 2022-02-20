//
//  TodayKeywordView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/20.
//

import UIKit

class TodayKeywordView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Color.tagGreen)
        self.layer.cornerRadius = 14
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  SearchBarView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/10.
//

import UIKit
import Then
import SnapKit

class SearchBarView: UIView {

    var backButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Back"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 18)
        }

    var searchField = UITextField()
        .then {
            $0.textColor = .white
        }

    var searchButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Search"), for: .normal)
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

extension SearchBarView {
    func setView() {
        self.backgroundColor = UIColor(rgb: 0x404040)
        self.layer.cornerRadius = 4.0

        self.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20.0)
            $0.width.equalTo(28.0)
            $0.height.equalTo(28.0)
        }

        self.addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(28.0)
            $0.height.equalTo(28.0)
        }

        self.addSubview(searchField)
        searchField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(backButton.snp.right).offset(5.0)
            $0.right.equalTo(searchButton.snp.left).offset(-10.0)
            $0.height.equalTo(30)
        }

    }
}

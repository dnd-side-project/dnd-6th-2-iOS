//
//  SubscribeListCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/09.
//

import UIKit

class SubscribeListCell: UITableViewCell {

    lazy var profileView = ProfileView(width: 42, height: 42, fontsize: 14)
    lazy var subscribeButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        self.selectionStyle = .none
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.subscribeStatus.isHidden = true
        profileView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -19).isActive = true

        self.addSubview(subscribeButton)
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false

        subscribeButton.setTitle("구독", for: .normal)
        subscribeButton.setTitleColor(.black, for: .normal)

        subscribeButton.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 9)
        subscribeButton.layer.cornerRadius = 18
        subscribeButton.backgroundColor = UIColor(rgb: 0xF0F0F0)

        subscribeButton.widthAnchor.constraint(equalToConstant: 57).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subscribeButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        subscribeButton.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
    }

}

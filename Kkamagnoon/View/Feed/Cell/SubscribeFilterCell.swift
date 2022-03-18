//
//  SubscribeFilterCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit

class SubscribeFilterCell: UICollectionViewCell {

    static let subscribeFilterCellIdentifier = "SubscribeFilterCellIdentifier"

    let profileImageView: UIImageView = UIImageView()
    let nickNameLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        DispatchQueue.main.async { [unowned self] in
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
            profileImageView.clipsToBounds = true
        }
    }

    func setView() {
        profileImageView.backgroundColor = .white
        self.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true

        nickNameLabel.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        nickNameLabel.font = UIFont.pretendard(weight: .medium, size: 11)
        nickNameLabel.textColor = .white
        self.addSubview(nickNameLabel)
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        nickNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9).isActive = true
        nickNameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
    }
}

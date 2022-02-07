//
//  ProfileView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit

class ProfileView: UIView {
    
    let profileImageView: UIImageView = UIImageView()
    let nickNameLabel: UILabel = UILabel()
    let subscribeStatus: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { [unowned self] in
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
            profileImageView.clipsToBounds = true
        }
    }
    
    func setView() {
        // 프로필 이미지
        profileImageView.backgroundColor = .white

        self.addSubview(profileImageView)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        profileImageView.widthAnchor.constraint(equalToConstant: 31).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        // 닉네임
        nickNameLabel.text = "닉네임"
        nickNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.addSubview(nickNameLabel)
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 9).isActive = true
        nickNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        // 구독 상태
        subscribeStatus.setTitle(StringType.notSubscribed, for: .normal)
        subscribeStatus.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        self.addSubview(subscribeStatus)
        subscribeStatus.translatesAutoresizingMaskIntoConstraints = false
        subscribeStatus.leftAnchor.constraint(equalTo: nickNameLabel.rightAnchor, constant: 7).isActive = true
        subscribeStatus.centerYAnchor.constraint(equalTo: nickNameLabel.centerYAnchor).isActive = true
  
    }
}

//
//  CommentCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//

import UIKit

class CommentCell: UITableViewCell {
    
    let profileView = ProfileView(width: 29, height: 29, fontsize: 14)
    let createdDateLabel = UILabel()
    let moreButton = UIButton()
    let commentContent = UITextView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        self.selectionStyle = .none
        setProfileView()
        setCreatedDateLabel()
        setMoreButton()
        setCommentContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProfileView() {
        self.addSubview(profileView)
        profileView.subscribeStatus.isHidden = true
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.5).isActive = true
        profileView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        
    }
    
    func setCreatedDateLabel() {
        self.addSubview(createdDateLabel)
        createdDateLabel.text = "8시간 전"
        createdDateLabel.textColor = UIColor(rgb: 0x999999)
        createdDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        createdDateLabel.translatesAutoresizingMaskIntoConstraints = false
        createdDateLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        createdDateLabel.leftAnchor.constraint(equalTo: profileView.nickNameLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setMoreButton() {
        self.addSubview(moreButton)
        moreButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        moreButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        moreButton.topAnchor.constraint(equalTo: profileView.topAnchor).isActive = true
    }
    
    func setCommentContent() {
        self.addSubview(commentContent)
        
        commentContent.translatesAutoresizingMaskIntoConstraints = false
        commentContent.isEditable = false
        commentContent.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        commentContent.sizeToFit()
        commentContent.isScrollEnabled = false
        commentContent.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        commentContent.backgroundColor = UIColor(rgb: Color.feedListCard)
        commentContent.textColor = .white
        
        
        commentContent.leftAnchor.constraint(equalTo: profileView.leftAnchor).isActive = true
        commentContent.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        commentContent.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 16).isActive = true
        commentContent.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23).isActive = true
    }
}
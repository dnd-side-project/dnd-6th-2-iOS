//
//  FeedCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit

class FeedCell: UICollectionViewCell {
    let profileImageView: UIImageView = UIImageView()
    let nickNameLabel: UILabel = UILabel()
    let subscribeStatus: UIButton = UIButton()

    let articleTitle: UILabel = UILabel()
    let articleContents: UITextView = UITextView()
    
    let likeLabel: UILabel = UILabel()
    let commentLabel: UILabel = UILabel()

    let moreButton: UIButton = UIButton()

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
//            profileImageView.clipsToBounds = true
        }
    }

    func setView() {
        profileImageView.backgroundColor = .white

        self.addSubview(profileImageView)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13).isActive = true

        profileImageView.widthAnchor.constraint(equalToConstant: 31).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 31).isActive = true

    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        let size = self.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        print(size)
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }

}

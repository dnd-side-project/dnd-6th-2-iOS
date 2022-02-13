//
//  FeedCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit

class FeedCell: UICollectionViewCell {
    let profileView: ProfileView = ProfileView(width: 31, height: 31, fontsize: 12)
    let updateDate: UILabel = UILabel()

    let articleTitle: UILabel = UILabel()
    let articleContents: UITextView = UITextView()

//    let likeLabel: UILabel = UILabel()
//    let commentLabel: UILabel = UILabel()

    let likeView: ImageLabelView = ImageLabelView()
    let commentView: ImageLabelView = ImageLabelView()

    let moreButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        profileView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true

        // 작성일
        updateDate.text = "2022년 2월 1일"
        updateDate.textColor = UIColor(rgb: 0x626262)

        updateDate.font = UIFont.pretendard(weight: .regular, size: 10)
        self.addSubview(updateDate)
        updateDate.translatesAutoresizingMaskIntoConstraints = false
        updateDate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        updateDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true

        // 글 제목
        articleTitle.textColor = .white
        articleTitle.font = UIFont.pretendard(weight: .semibold, size: 14)
        self.addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
        articleTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true

        // 글 내용

        articleContents.setTextWithLineHeight(
            text: StringType.dummyContents,
            lineHeight: 20,
            fontSize: 13,
            fontWeight: .regular,
            color: UIColor(rgb: Color.content)
        )
        articleContents.textContainer.maximumNumberOfLines = 5
        articleContents.textContainer.lineBreakMode = .byTruncatingTail

        articleContents.backgroundColor = UIColor(rgb: Color.feedListCard)
        articleContents.sizeToFit()
        articleContents.isScrollEnabled = false
        articleContents.isEditable = false
        articleContents.isSelectable = false
        articleContents.isUserInteractionEnabled = false
        articleContents.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        self.addSubview(articleContents)
        articleContents.translatesAutoresizingMaskIntoConstraints = false
        articleContents.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        articleContents.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 17).isActive = true
        articleContents.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true

        // 공감

        self.addSubview(likeView)
        likeView.snp.makeConstraints {
            $0.top.equalTo(articleContents.snp.bottom).offset(14.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.bottom.equalToSuperview().offset(-15.0)
        }

        // 댓글

        self.addSubview(commentView)
        commentView.snp.makeConstraints {
            $0.centerY.equalTo(likeView)
            $0.left.equalTo(likeView.snp.right).offset(32.0)
        }

        // 더보기(신고하기)
        moreButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        self.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(likeView)
            $0.size.equalTo(24.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

    }

    private func makeImageAttatchLabel(imageName: String, text: String) -> NSMutableAttributedString {
        let contentString = NSMutableAttributedString(string: "")
        let attachment = NSTextAttachment()

        attachment.image = UIImage(systemName: imageName)
        let attachmentImage = NSAttributedString(attachment: attachment)
        let attachmentString = NSAttributedString(string: text)
        contentString.append(attachmentImage)
        contentString.append(attachmentString)

        return contentString
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
//        layoutIfNeeded()
        let size = self.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }

}

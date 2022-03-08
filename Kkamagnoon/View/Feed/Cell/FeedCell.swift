//
//  FeedCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit
import Then
import RxSwift

class FeedCell: UICollectionViewCell {
    static let feedCellIdentifier = "FeedCellIdentifier"

    let profileView: ProfileView = ProfileView(width: 31, height: 31, fontsize: 12)
    let updateDate: UILabel = UILabel()

    let articleTitle: UILabel = UILabel()
    let articleContents = UILabel()

//    let likeLabel: UILabel = UILabel()
//    let commentLabel: UILabel = UILabel()

    let likeView: ImageLabelView = ImageLabelView()
        .then {
            $0.imageView.image = UIImage(named: "Heart")
        }

    let commentView: ImageLabelView = ImageLabelView()
        .then {
            $0.imageView.image = UIImage(named: "Comment")
        }

    let moreButton: UIButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "More"), for: .normal)
        }

    // FIXME: 뷰 컨트롤러 - 컬렉션뷰 - 셀 - 버튼 Binding은 셀 내부의 disposeBag을 이용해야 문제가 안 생깁니다. 추후 참고하시면 좋을 것 같아요.
    var disposeBag = DisposeBag()
    override func prepareForReuse() {
      super.prepareForReuse()
      disposeBag = DisposeBag()
      // TODO: 셀 내용 초기화...
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        self.layer.cornerRadius = 15.0
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        self.layer.cornerRadius = 15.0
        setView()
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
        articleTitle.text = "무제"
        articleTitle.textColor = .white
        articleTitle.font = UIFont.pretendard(weight: .semibold, size: 14)
        self.addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
        articleTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true

        // 글 내용
        articleContents.font = UIFont.pretendard(weight: .regular, size: 13)
        articleContents.textColor = UIColor(rgb: Color.content)
        articleContents.numberOfLines = 5
        articleContents.lineBreakMode = .byTruncatingTail
        articleContents.backgroundColor = UIColor(rgb: Color.feedListCard)
        articleContents.setTextWithLineHeight(text: "", lineHeight: .lineheightInBox)

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
        self.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(likeView)
            $0.size.equalTo(24.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

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

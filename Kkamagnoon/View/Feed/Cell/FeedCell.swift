//
//  FeedCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit
import Then
import SnapKit
import RxSwift

class FeedCell: UICollectionViewCell {
    static let feedCellIdentifier = "FeedCellIdentifier"

    let profileView: ProfileView = ProfileView(width: 31, height: 31, fontsize: 12)
    let updateDate: UILabel = UILabel()
        .then {
            $0.textColor = UIColor.appColor(.subTextGray)
            $0.font = UIFont.pretendard(weight: .regular, size: 10)
        }

    let articleTitle: UILabel = UILabel()
        .then {
            // TEMP
            $0.text = "무제"
            $0.textColor = .white
            $0.font = UIFont.pretendard(weight: .semibold, size: 14)
        }

    let articleContents = UILabel()
        .then {
            $0.font = UIFont.pretendard(weight: .regular, size: 13)
            $0.textColor = UIColor(rgb: Color.content)
            $0.numberOfLines = 5
            $0.lineBreakMode = .byTruncatingTail
            $0.setTextWithLineHeight(text: "", lineHeight: .lineheightInBox)
        }

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
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(rgb: Color.feedListCard)
        self.layer.cornerRadius = 15.0
        setLayout()
    }

    func setLayout() {
        self.addSubview(profileView)

        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13.0)
            $0.left.equalToSuperview().offset(20.0)
        }

        // 작성일
        self.addSubview(updateDate)
        updateDate.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15.0)
            $0.right.equalToSuperview().offset(-16.0)
        }

        // 글 제목
        self.addSubview(articleTitle)
        articleTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        // 글 내용
        self.addSubview(articleContents)
        articleContents.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(articleTitle.snp.bottom).offset(17.0)
        }

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

    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()

        let size = self.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame

        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }

}

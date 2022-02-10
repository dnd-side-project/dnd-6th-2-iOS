//
//  BottomReactionView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/09.
//

import UIKit
import RxCocoa
import RxSwift

class BottomReactionView: UIView {

    lazy var likeButton: UIButton = UIButton()
    lazy var commentButton: UIButton = UIButton()
    lazy var bookmarkButton: UIButton = UIButton()

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.setTitle("80", for: .normal)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false

        likeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        likeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        commentButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        commentButton.setTitle("80", for: .normal)
        commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.addSubview(commentButton)
        commentButton.translatesAutoresizingMaskIntoConstraints = false

        commentButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 32).isActive = true
        commentButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        commentButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        commentButton.rx.tap
            .bind {

            }
            .disposed(by: disposeBag)

        bookmarkButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        bookmarkButton.setTitle("80", for: .normal)
        bookmarkButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.addSubview(bookmarkButton)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false

        bookmarkButton.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: 32).isActive = true
        bookmarkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        bookmarkButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }

}

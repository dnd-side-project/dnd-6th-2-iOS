//
//  FeedMainView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleListView: UIView {

    var collectionView: UICollectionView!

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: TabBarViewController.tabbarHeight, right: 0)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.feedCellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.backgroundColor = .black

        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 40,
                                          height: collectionView.frame.height)

        collectionView.collectionViewLayout = layout

        self.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor
            .constraint(equalTo: self.bottomAnchor).isActive = true

    }

}

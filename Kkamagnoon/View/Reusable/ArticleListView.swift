//
//  FeedMainView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit
import RxSwift
import RxCocoa
import Then

class ArticleListView: UIView {

    var collectionView: UICollectionView!

    let disposeBag = DisposeBag()

    let layout = UICollectionViewFlowLayout()
        .then {
            $0.minimumInteritemSpacing = 10
            $0.scrollDirection = .vertical
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: TabBarViewController.tabbarHeight, right: 0)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(rgb: Color.basicBackground)

        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 40,
                                          height: collectionView.frame.height)

        collectionView.collectionViewLayout = layout

        self.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.bottomAnchor
            .constraint(equalTo: self.bottomAnchor).isActive = true

    }

}

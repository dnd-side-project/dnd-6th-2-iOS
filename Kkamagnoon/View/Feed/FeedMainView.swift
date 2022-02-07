//
//  FeedMainView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit
import RxSwift
import RxCocoa

class FeedMainView: UIView {

    var feedCollectionView: UICollectionView!

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
        layout.minimumInteritemSpacing = 11
        layout.scrollDirection = .vertical

        feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        feedCollectionView.register(FeedCell.self, forCellWithReuseIdentifier: CellIdentifier.feed)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 40,
                                          height: feedCollectionView.frame.height)
        feedCollectionView.showsVerticalScrollIndicator = false
        feedCollectionView.collectionViewLayout = layout
        
        self.addSubview(feedCollectionView)

        feedCollectionView.translatesAutoresizingMaskIntoConstraints = false

        feedCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        feedCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        feedCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        feedCollectionView.bottomAnchor
            .constraint(equalTo: self.bottomAnchor).isActive = true

    }

}

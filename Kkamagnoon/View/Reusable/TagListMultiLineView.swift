//
//  TagListMultiLineView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import RxSwift
import RxCocoa

class TagListMultiLineView: UIView {

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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 5
//        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        collectionView.register(RelayRoomCell.self, forCellWithReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier)

//        collectionView.backgroundColor = .black

//        collectionView.showsHorizontalScrollIndicator = false

        let width = collectionView.frame.width
        flowLayout.estimatedItemSize = CGSize(width: width, height: 30)

        collectionView.collectionViewLayout = flowLayout
        self.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let testData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        testData
            .bind(to: collectionView.rx
                    .items(cellIdentifier: CategoryFilterCell.categoryFilterCellIdentifier,
                               cellType: CategoryFilterCell.self)) { (_, element, cell) in
                cell.tagView.categoryLabel.text = element

        }
        .disposed(by: disposeBag)

    }

}

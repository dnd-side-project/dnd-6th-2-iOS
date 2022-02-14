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
    var flowLayout = LeftAlignedCollectionViewFlowLayout()
    let disposeBag = DisposeBag()

    var heightConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        DispatchQueue.main.async {
            self.heightConstraint.constant = self.collectionView.contentSize.height
        }
    }

    func setView() {

        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5.95
        flowLayout.minimumInteritemSpacing = 4.25
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .brown

        let width = collectionView.frame.width
        flowLayout.estimatedItemSize = CGSize(width: width, height: 30)
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        collectionView.collectionViewLayout = flowLayout

        self.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        let testData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        testData
            .bind(to: collectionView.rx
                    .items(cellIdentifier: CategoryFilterCell.categoryFilterCellIdentifier,
                               cellType: CategoryFilterCell.self)) { (_, element, cell) in
                cell.tagView.categoryLabel.text = element
                cell.tagView.backgroundColor = UIColor(rgb: 0x343434)

        }
        .disposed(by: disposeBag)

//        collectionView.layoutIfNeeded()
    }

}

//
//  TagListView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/11.
//

import UIKit
import RxSwift

class TagListView: UIView {

    var filterView: UICollectionView!
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
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)

        filterView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filterView.register(CategoryFilterCell.self, forCellWithReuseIdentifier: CategoryFilterCell.categoryFilterCellIdentifier)
        filterView.allowsMultipleSelection = true

        filterView.backgroundColor = .black

        filterView.showsHorizontalScrollIndicator = false

        let width = filterView.frame.width
        flowLayout.estimatedItemSize = CGSize(width: width, height: 30)
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        filterView.collectionViewLayout = flowLayout
        self.addSubview(filterView)

        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        filterView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        filterView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        filterView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let testData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        testData
            .bind(to: filterView.rx
                    .items(cellIdentifier: CategoryFilterCell.categoryFilterCellIdentifier,
                               cellType: CategoryFilterCell.self)) { (_, element, cell) in
                cell.tagView.categoryLabel.text = element

        }
        .disposed(by: disposeBag)

    }

}

//
//  WholeFeedView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

class WholeFeedView: FeedView {
    
    override func setFilterView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)

        filterView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filterView.register(CategoryFilterCell.self, forCellWithReuseIdentifier: CellIdentifier.categoryFilter)
        filterView.backgroundColor = .black
        filterView.showsHorizontalScrollIndicator = false

        let width = filterView.frame.width
        flowLayout.estimatedItemSize = CGSize(width: width, height: 29)

        filterView.collectionViewLayout = flowLayout
        self.addSubview(filterView)

        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        filterView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        filterView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        filterView.heightAnchor.constraint(equalToConstant: 29).isActive = true

        let testData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕", " "])

        testData
            .bind(to: filterView.rx
                        .items(cellIdentifier: CellIdentifier.categoryFilter,
                               cellType: CategoryFilterCell.self)) { (_, element, cell) in
                cell.layer.cornerRadius = 18
                cell.categoryLabel.text = element
        }
        .disposed(by: disposeBag)
    }
    
    override func setSortButton() {
        sortButton.setTitle("인기순", for: .normal)
        sortButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        sortButton.sizeToFit()
        sortButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.addSubview(sortButton)

        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 22).isActive = true
        sortButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -27).isActive = true
    }
}

//
//  AuthorListView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/11.
//

import UIKit
import RxSwift

class AuthorListView: UIView {

    var filterView: UICollectionView!
    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 3
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)

        filterView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filterView.register(SubscribeFilterCell.self, forCellWithReuseIdentifier: SubscribeFilterCell.subscribeFilterCellIdentifier)
        filterView.backgroundColor = UIColor(rgb: Color.basicBackground)
        filterView.showsHorizontalScrollIndicator = false

        let width = filterView.frame.width
        flowLayout.estimatedItemSize = CGSize(width: width, height: 106)

        filterView.collectionViewLayout = flowLayout
        self.addSubview(filterView)

        filterView.translatesAutoresizingMaskIntoConstraints = false

        filterView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        filterView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        filterView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        filterView.heightAnchor.constraint(equalToConstant: 106).isActive = true

        let testData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        testData
            .bind(to: filterView.rx
                    .items(cellIdentifier: SubscribeFilterCell.subscribeFilterCellIdentifier,
                               cellType: SubscribeFilterCell.self)) { (_, element, cell) in

                cell.layer.cornerRadius = 6
                cell.nickNameLabel.text = element
        }
        .disposed(by: disposeBag)

    }

}

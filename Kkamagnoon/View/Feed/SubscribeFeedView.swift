//
//  SubscribeFeedView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

class SubscribeFeedView: FeedView {
    lazy var goAllListButton = UIButton()

    override func setFilterView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 3

        filterView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filterView.register(SubscribeFilterCell.self, forCellWithReuseIdentifier: CellIdentifier.subscribeFilter)
        filterView.backgroundColor = .black
        filterView.showsHorizontalScrollIndicator = false

        let width = filterView.frame.width
        flowLayout.estimatedItemSize = CGSize(width: width, height: 29)

        filterView.collectionViewLayout = flowLayout
        self.addSubview(filterView)

        filterView.translatesAutoresizingMaskIntoConstraints = false

        filterView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        filterView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        filterView.heightAnchor.constraint(equalToConstant: 106).isActive = true

        goAllListButton.setTitle("전체", for: .normal)
        goAllListButton.setTitleColor(UIColor(rgb: 0x5FCEA0), for: .normal)
        goAllListButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.addSubview(goAllListButton)
        goAllListButton.translatesAutoresizingMaskIntoConstraints = false
        goAllListButton.leftAnchor.constraint(equalTo: filterView.rightAnchor).isActive = true
        goAllListButton.widthAnchor.constraint(equalToConstant: 83).isActive = true
        goAllListButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        goAllListButton.heightAnchor.constraint(equalTo: filterView.heightAnchor).isActive = true

        goAllListButton.rx.tap
            .bind {
                let vc = SubscribeListViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.hidesBottomBarWhenPushed = true
                self.viewController?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)

        let testData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕", " "])

        testData
            .bind(to: filterView.rx
                        .items(cellIdentifier: CellIdentifier.subscribeFilter,
                               cellType: SubscribeFilterCell.self)) { (_, element, cell) in

                cell.layer.cornerRadius = 6
                cell.nickNameLabel.text = element
        }
        .disposed(by: disposeBag)
    }

    override func setFeedMainViewTop() {
        feedMainView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 15).isActive = true
    }

}

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
        filterView = AuthorListView()
        self.addSubview(filterView)
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        filterView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        filterView.heightAnchor.constraint(equalToConstant: 106).isActive = true

        goAllListButton.setTitle("전체", for: .normal)
        goAllListButton.setTitleColor(UIColor(rgb: 0x5FCEA0), for: .normal)

        goAllListButton.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 14)
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
    }

    override func setFeedMainViewTop() {
        articleListView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 15).isActive = true
    }
}

//
//  BellNoticeViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import UIKit
import SnapKit
import Then

class BellNoticeViewController: UIViewController {

    var headerView = HeaderViewWithBackBtn()
        .then {
            $0.titleLabel.text = "알림"
            $0.bellButton.isHidden = true
            $0.noticeButton.isHidden = true
        }

    var noticeListView = ArticleListView()
        .then {
            $0.collectionView.register(NoticeCell.self, forCellWithReuseIdentifier: NoticeCell.idenfier)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setView()

    }

}

extension BellNoticeViewController {
    func setView() {
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        view.addSubview(noticeListView)
        noticeListView.backgroundColor = .brown
        noticeListView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(15.0)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

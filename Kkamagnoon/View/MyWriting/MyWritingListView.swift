//
//  MyWritingListView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/08.
//

import UIKit

class MyWritingListView: UIView {

    var tagListView = TagListView()

    var writingListView = ArticleListView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        self.addSubview(tagListView)
        tagListView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(22.0)
            $0.right.equalToSuperview().offset(-22.0)
            $0.height.equalTo(30.0)
        }

        self.addSubview(writingListView)
        writingListView.snp.makeConstraints {
            $0.top.equalTo(tagListView.snp.bottom).offset(16.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview()
        }

    }
}

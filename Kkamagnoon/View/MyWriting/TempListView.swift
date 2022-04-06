//
//  TempListView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/08.
//

import UIKit
import Then
import SnapKit

class TempListView: UIView {

    var articleListView = ArticleListView()
        .then {
            $0.collectionView.register(MyWritingCell.self, forCellWithReuseIdentifier: MyWritingCell.identifier)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
}

extension TempListView {
    func setView() {
        self.addSubview(articleListView)
        articleListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

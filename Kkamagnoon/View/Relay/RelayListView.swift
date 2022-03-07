//
//  RelayListView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import UIKit

class RelayListView: ArticleListView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        layout.headerReferenceSize = CGSize(width: self.frame.width, height: 40)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

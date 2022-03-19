//
//  SearchResultView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/19.
//

import UIKit
import Then
import SnapKit

class SearchResultView: UIView {

    var menuTabView = SearchTabTitleView()

    var countLabel = UILabel()
        .then {
            $0.font = UIFont.pretendard(weight: .regular, size: 14.0)
            $0.textColor = UIColor(rgb: 0xCCCCCC)
        }
    var searchResultListView = ArticleListView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

}

extension SearchResultView {
    func setView() {
        self.addSubview(menuTabView)
        menuTabView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.height.equalTo(46.0)
        }

        DispatchQueue.main.async {
            self.menuTabView.menuCollectionView.selectItem(at: IndexPath(item: .zero, section: .zero), animated: false, scrollPosition: [])
        }

//        self.addSubview(countLabel)

        self.addSubview(searchResultListView)
        searchResultListView.snp.makeConstraints {
            $0.top.equalTo(menuTabView.snp.bottom).offset(21.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview()
        }
    }
}

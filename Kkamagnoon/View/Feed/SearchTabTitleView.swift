//
//  SearchTabTitleView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/19.
//

import UIKit
import Then
import SnapKit

class SearchTabTitleView: UIView {

    var menuCollectionView: UICollectionView!
    var menuCollectionViewFlowLayout = UICollectionViewFlowLayout()
        .then {
            $0.scrollDirection = .horizontal
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }

    var indicatorView = UIView()
        .then {
            $0.backgroundColor = .white
        }

    var indicatorViewWidthContraint: NSLayoutConstraint!
    var indicatorViewLeftContraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setView()
    }
}

extension SearchTabTitleView {
    func setView() {
        menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: menuCollectionViewFlowLayout)

        menuCollectionView.showsHorizontalScrollIndicator = false
        menuCollectionView.register(SearchTabMenuCell.self, forCellWithReuseIdentifier: SearchTabMenuCell.identifier)

        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.width.equalTo(self.bounds.width / 3)
            $0.height.equalTo(3.0)
            $0.bottom.equalToSuperview()
        }

        indicatorViewLeftContraint = indicatorView.leftAnchor.constraint(equalTo: self.leftAnchor)
        indicatorViewLeftContraint.isActive = true

        self.addSubview(menuCollectionView)
        menuCollectionView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(indicatorView.snp.top)
        }
    }
}

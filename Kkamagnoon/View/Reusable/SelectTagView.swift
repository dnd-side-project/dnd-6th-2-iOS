//
//  SelectTagView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/19.
//

import UIKit
import Then
import SnapKit

class SelectTagView: UIView {

    let layout = UICollectionViewFlowLayout()
        .then {
            $0.itemSize.width = (UIScreen.main.bounds.width - 40 - 8)/2
            $0.itemSize.height = 53.5
            $0.minimumInteritemSpacing = 8
            $0.minimumLineSpacing = 20.68
            $0.scrollDirection = .vertical
            $0.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 124)
        }

    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = UIColor(rgb: Color.basicBackground)

        collectionView.register(
            SelectingTagCell.self,
            forCellWithReuseIdentifier: SelectingTagCell.selectingTagCellIdentifier
        )

        collectionView.register(
            SelectingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SelectingCollectionReusableView.identifier)

        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }

}

//
//  AddingTagView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/24.
//

import UIKit
import RxCocoa
import RxSwift
import Then
import SnapKit

class AddingTagView: UIView {

    var collectionView: UICollectionView!
    let disposeBag = DisposeBag()

    var layout = UICollectionViewFlowLayout()
        .then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 5
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
            $0.estimatedItemSize = CGSize(
                width: UIScreen.main.bounds.width - 40,
                height: 30
            )
        }

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

        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        self.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
}

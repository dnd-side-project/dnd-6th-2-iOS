//
//  SortHeaderCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class SortHeaderCell: UICollectionReusableView {

    static let sortHeaderCellReuseIdentifier = "SortHeaderCellReuseIdentifier"

    var disposeBag = DisposeBag()

    var sortButton = UIButton()
        .then {
            $0.setTitle("최신순", for: .normal)
            $0.setImage(UIImage(named: "Sort"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 0)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.sizeToFit()
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 12)
        }

    var buttonTappedHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        bindView()
    }

    func setView() {
        self.addSubview(sortButton)
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.0 - 11.83)
            $0.right.equalToSuperview().offset(-7.0)
            $0.bottom.equalToSuperview().offset(-11.83)

        }
    }

    func bindView() {

        sortButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.buttonTappedHandler?()
            }
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

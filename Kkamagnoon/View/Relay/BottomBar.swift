//
//  BottomBar.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class BottomBar: UIView {

    lazy var grayLine: GrayBorderView = GrayBorderView()

    lazy var verticalFormulaButton: UIButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    lazy var horizontalFormulaButton: UIButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    lazy var participantButton: UIButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(grayLine)
        grayLine.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(-0.5)
        }

        self.addSubview(verticalFormulaButton)

        verticalFormulaButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.top.equalToSuperview().offset(14.0)
            $0.bottom.equalToSuperview()
        }

        self.addSubview(horizontalFormulaButton)

        horizontalFormulaButton.snp.makeConstraints {
            $0.left.equalTo(verticalFormulaButton.snp.right).offset(10.13)
            $0.centerY.equalTo(verticalFormulaButton)
        }

        self.addSubview(participantButton)

        participantButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20.72)
            $0.centerY.equalTo(verticalFormulaButton)
        }

    }

}

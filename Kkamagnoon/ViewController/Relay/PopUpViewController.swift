//
//  PopUpViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class PopUpViewController: UIViewController {

    var disposeBag = DisposeBag()

    var backView = UIView()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x1C1C1C)
            $0.alpha = 0.8
        }

    var popUpView = PopUpView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    func setView() {
        view.addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(popUpView)

        popUpView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(276.0)
            $0.width.equalToSuperview().offset(-74.0)
        }

        popUpView.exitButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismiss(animated: false, completion: nil)
            }
            .disposed(by: disposeBag)

        popUpView.enterButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                // 릴레이 방 입장

                owner.dismiss(animated: false, completion: nil)

            }
            .disposed(by: disposeBag)
    }

}

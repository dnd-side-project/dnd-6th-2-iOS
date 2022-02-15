//
//  MakingRelayRoomViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class MakingRelayRoomViewController: UIViewController {

    var disposeBag = DisposeBag()

    var scrollView = UIScrollView()
          .then {
              $0.showsVerticalScrollIndicator = false

          }

    var makingRelayView = MakingRelayView()

    var enterButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x242424)
            $0.setTitle("시작하기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 18)
            $0.setTitleColor(UIColor(rgb: 0xA0A0A0), for: .normal)
            $0.layer.cornerRadius = 10
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)

        setView()
    }

    func setView() {

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        scrollView.addSubview(makingRelayView)

        makingRelayView.snp.makeConstraints {
            $0.width.equalToSuperview()

            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        view.addSubview(enterButton)
        enterButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-40.0)
            $0.height.equalTo(56.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40.0)
        }

        enterButton.rx.tap
            .bind {

            }
            .disposed(by: disposeBag)
    }

}

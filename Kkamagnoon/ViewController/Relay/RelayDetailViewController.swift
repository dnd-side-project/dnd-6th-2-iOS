//
//  RelayDetailViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class RelayDetailViewController: UIViewController {

    var disposeBag = DisposeBag()

    var detailView = RelayDetailView()

    var enterButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
            $0.setTitle("방 입장하기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 18)
            $0.setTitleColor(UIColor(rgb: 0xF0F0F0), for: .normal)
            $0.layer.cornerRadius = 10
        }

    var bottomBar = BottomBar()
        .then {
            $0.frame.size.height = 70
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true

        setView()
        layoutView()
    }

    func setView() {

        view.addSubview(detailView)
        view.addSubview(enterButton)
        view.addSubview(bottomBar)
    }

    func layoutView() {

        detailView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        enterButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-40.0)
            $0.height.equalTo(56.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40.0)
        }

        enterButton.rx.tap
            .bind {
                let vc = PopUpViewController()
                vc.modalPresentationStyle = .overFullScreen

                self.present(vc, animated: false)
            }
            .disposed(by: disposeBag)

        bottomBar.snp.makeConstraints {
            $0.left.bottom.right.equalTo(view.safeAreaLayoutGuide)
        }

        bottomBar.participantButton.rx.tap
            .bind {
                let vc = ParticipantViewController()
                vc.modalPresentationStyle = .fullScreen

                self.present(vc, animated: false, completion: nil)
            }
            .disposed(by: disposeBag)
    }

}

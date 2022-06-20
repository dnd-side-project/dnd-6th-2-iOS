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

class PopUpViewController: BaseViewController {

    var disposeBag = DisposeBag()
    let viewModel = PopUpViewModel()

    var backView = UIView()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x1C1C1C)
            $0.alpha = 0.8
        }

    var popUpView = PopUpView()
    var imageView = UIImageView()
        .then {
            $0.image = UIImage(named: "RelayRoomAlertCharacter")
            $0.contentMode = .scaleAspectFit
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setLayout()
        bindInput()
        bindOutput()
    }

    func setLayout() {
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

        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(125.72)
            $0.height.equalTo(110.41)
            $0.bottom.equalTo(popUpView.alertTitleLabel.snp.top).offset(-7.13)
        }
    }

    func bindInput() {
        popUpView.exitButton.rx.tap
            .bind(to: viewModel.input.exitButtonTap)
            .disposed(by: disposeBag)

        popUpView.enterButton.rx.tap
            .bind(to: viewModel.input.enterButtonTap)
            .disposed(by: disposeBag)
    }

    func bindOutput() {
        viewModel.output.relayDetailViewStyle
            .asDriver()
            .drive(onNext: closePopUpView)
            .disposed(by: disposeBag)
    }

}

extension PopUpViewController {
    private func closePopUpView(_ style: RelayRoomState) {
        self.dismiss(animated: false, completion: nil)
    }
}

//
//  SuccessPopUpVC+Ext.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/08.
//

extension SuccessPopUpViewController {
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

        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(125.72)
            $0.height.equalTo(110.41)
            $0.bottom.equalTo(popUpView.alertTitleLabel.snp.top).offset(-7.13)
        }
    }

    func bindView() {
        // Input
        popUpView.enterButton.rx.tap
            .bind(to: viewModel.input.enterButtonTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.relayDetailViewStyle
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismiss(animated: false, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}

//
//  ChallengeSelectingTagVC+Ext.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/08.
//
import RxSwift
import RxDataSources

extension ChallengeSelectingTagViewController {
    func setView() {

        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(21.0)
            $0.size.equalTo(28.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(26.24)
        }

        view.addSubview(stackView)
        stackView.addArrangedSubview(tempSaveButton)
        stackView.addArrangedSubview(completeButton)

        stackView.snp.makeConstraints {

            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview().offset(-42.0)
            $0.height.equalTo(54.0)
        }

        view.addSubview(selectTagView)
        Observable.just([SectionModel(model: "title", items: StringType.categories)])
            .bind(to: selectTagView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        selectTagView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(backButton.snp.bottom)
            $0.bottom.equalTo(stackView.snp.top).offset(-20)
        }
    }
}

extension ChallengeSelectingTagViewController {
    func bindView() {
        // Input
        backButton.rx.tap
            .bind(to: viewModel.input.backButtonTap)
            .disposed(by: disposeBag)

        selectTagView.collectionView.rx
            .modelSelected(String.self)
            .bind(to: viewModel.input.tagTap)
            .disposed(by: disposeBag)

        tempSaveButton.rx.tap
            .bind(to: viewModel.input.tempSaveButtonTap)
            .disposed(by: disposeBag)

        completeButton.rx.tap
            .bind(to: viewModel.input.completeButtonTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.goToMainView
            .withUnretained(self)
            .bind { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToMainView
            .withUnretained(self)
            .bind { owner, _ in
                owner.navigationController?.popToRootViewController(animated: false)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToMainViewAndPopUp
            .withUnretained(self)
            .bind { owner, _ in
                owner.navigationController?.popToRootViewController(animated: false, completion: {
                    let vc = SuccessPopUpViewController()
                    vc.modalPresentationStyle = .fullScreen

                    owner.viewModel.rootView?.present(vc, animated: false, completion: nil)
                })

            }
            .disposed(by: disposeBag)
    }
}

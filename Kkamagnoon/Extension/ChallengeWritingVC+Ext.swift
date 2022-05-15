//
//  ChallengeWritingVC+Ext.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/08.
//

import IQKeyboardManagerSwift
import UIKit

extension WritingViewController {

    func setKeyBoard() {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }

    func layoutView() {

        view.addSubview(header)
        setButton(state: false)
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        header.noticeButton.snp.makeConstraints {
            $0.width.equalTo(57)
            $0.height.equalTo(25)
        }

        view.addSubview(writingSubView)
        writingSubView.snp.makeConstraints {
            $0.height.equalTo(68.0)
            $0.left.right.equalToSuperview()

        }
        writingSubViewBottomConstraint = writingSubView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44)
        writingSubViewBottomConstraint.isActive = true

        view.addSubview(writingView)
        writingView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(33.0)
            $0.bottom.equalTo(writingSubView.snp.top)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        view.addSubview(tipBox)
        tipBox.snp.makeConstraints {
            $0.height.equalTo(66.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(writingSubView.snp.top).offset(-13.0)
        }

    }

}

extension WritingViewController {
    func bindInput() {
        header.noticeButton.rx.tap
            .bind(to: viewModel.input.completeButtonTap)
            .disposed(by: disposeBag)

        writingView.titleTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.title)
            .disposed(by: disposeBag)

        writingView.contentTextView.rx.text
            .orEmpty
            .bind(to: viewModel.input.contents)
            .disposed(by: disposeBag)
    }

    func bindOutput() {
        viewModel.output.enableCompleteButton
            .withUnretained(self)
            .bind { owner, value in
                owner.header.noticeButton.isEnabled = value
                owner.setButton(state: value)
            }
            .disposed(by: disposeBag)

        viewModel.output.tips
            .withUnretained(self)
            .bind { owner, tips in
                owner.tipBox.textLabel.text = tips
            }
            .disposed(by: disposeBag)

        viewModel.output.goToSelection
            .withUnretained(self)
            .bind { owner, articleDTO in
                owner.goToTagSelectigVC(articleDTO: articleDTO)
            }
            .disposed(by: disposeBag)
    }
}

extension WritingViewController {
    private func goToTagSelectigVC(articleDTO: CreateArticleDTO ) {
        let vc = ChallengeSelectingTagViewController()
        vc.modalPresentationStyle = .fullScreen

        vc.viewModel.articleDTO = articleDTO
        vc.viewModel.rootView = self.viewModel.rootView

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func setButton(state: Bool) {
        if state {
            header.noticeButton.backgroundColor = UIColor(rgb: Color.whitePurple)
        } else {
            // TEMP
            header.noticeButton.backgroundColor = UIColor(rgb: Color.tag)
        }
    }
}

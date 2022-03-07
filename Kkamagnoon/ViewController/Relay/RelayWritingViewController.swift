//
//  RelayWritingViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/19.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift
import RxCocoa

class RelayWritingViewController: UIViewController {

    var disposeBag = DisposeBag()
    let viewModel = WritingViewModel()

    var header = HeaderViewWithBackBtn()
        .then {
            $0.titleLabel.isHidden = true
            $0.bellButton.isHidden = true
            $0.noticeButton.isEnabled = false
        }

    var writingView = WritingView()
        .then {
            $0.titleTextField.isHidden = true
            $0.contentTextView.backgroundColor = .clear
        }

    var writingSubView = WritingSubView()

    var tipBox = TipBox()

    let keyboardShowObserver  = NotificationCenter.default.keyboardWillShowObservable()

    let keyboardHideObserver = NotificationCenter.default.keyboardWillHideObservable()

    private var writingSubViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        setKeyBoard()
        animateWritingViewGoUp()
        animateWritingViewGoDown()
        setView()

        bindView()
        viewModel.bindTips()
    }

}

extension RelayWritingViewController {

    func setKeyBoard() {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }

    func setView() {

        view.addSubview(header)
//        setButton(state: false)
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
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

    func animateWritingViewGoUp() {

        keyboardShowObserver
            .bind { [weak self] keyboardAnimationInfo in
                guard let self = self else { return }

                UIView.animate(withDuration: keyboardAnimationInfo.duration,
                               delay: .zero,
                               options: [UIView.AnimationOptions(rawValue: keyboardAnimationInfo.curve)]) {
                    self.writingSubViewBottomConstraint.constant = -keyboardAnimationInfo.height
                }
                self.view.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
    }

    func animateWritingViewGoDown() {

        keyboardHideObserver
            .bind { [weak self] keyboardAnimationInfo in
                guard let self = self else { return }

                UIView.animate(withDuration: keyboardAnimationInfo.duration,
                               delay: .zero,
                               options: [UIView.AnimationOptions(rawValue: keyboardAnimationInfo.curve)]) {
                    self.writingSubViewBottomConstraint.constant = -44
                }
                self.view.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
    }
}

extension RelayWritingViewController {
    func bindView() {

        // Input
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

        // Output
        viewModel.output.enableCompleteButton
            .withUnretained(self)
            .bind { owner, value in
                owner.header.noticeButton.isEnabled = value
//                owner.setButton(state: value)
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
            .bind { _, _ in
//                owner.goToTagSelectigVC(articleDTO: articleDTO)
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

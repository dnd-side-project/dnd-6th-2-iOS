//
//  WritingViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/19.
//
import UIKit
import IQKeyboardManagerSwift
import RxSwift
import RxCocoa

class WritingViewController: UIViewController {

    var disposeBag = DisposeBag()

    var header = HeaderViewWithBackBtn()
        .then {
            $0.titleLabel.isHidden = true
            $0.bellButton.isHidden = true

        }

    var writingView = WritingView()
        .then {
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
        view.backgroundColor = .black
        setKeyBoard()
        animateWritingViewGoUp()
        animateWritingViewGoDown()
        setView()
    }

}

extension WritingViewController {

    func setKeyBoard() {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }

    func setView() {
        view.addSubview(header)
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

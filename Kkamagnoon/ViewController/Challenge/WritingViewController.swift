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
    let viewModel = WritingViewModel()

    var header = HeaderViewWithBackBtn()
        .then {
            $0.titleLabel.isHidden = true
            $0.bellButton.isHidden = true
            $0.noticeButton.isEnabled = false
            $0.noticeButton.setTitleColor(.white, for: .normal)
            $0.noticeButton.titleLabel?.font = UIFont.pretendard(weight: .semibold, size: 14)
            $0.noticeButton.setTitle("다음", for: .normal)
            $0.noticeButton.setImage(nil, for: .normal)
            $0.noticeButton.layer.cornerRadius = 18
//            $0.layer.cornerCurve = .continuous
        }

    var writingView = WritingView()
        .then {
            $0.contentTextView.backgroundColor = .clear
        }

    var writingSubView = WritingSubView()

    var tipBox = TipBox()

    let keyboardShowObserver  = NotificationCenter.default.keyboardWillShowObservable()

    let keyboardHideObserver = NotificationCenter.default.keyboardWillHideObservable()

    var writingSubViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        setKeyBoard()
        setWritingSubView()

        layoutView()
        bindInput()
        bindOutput()
        viewModel.bindTips()
    }

}

extension WritingViewController {

    func setWritingSubView() {
        setAnimateWritingSubView()
        setWritingSubViewButtonHandler()
    }

    func setAnimateWritingSubView() {
        animateWritingViewGoUp()
        animateWritingViewGoDown()
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

    func setWritingSubViewButtonHandler() {
        writingSubView.copyWritingButtonTapHandler = { [weak self] in
            UIPasteboard.general.string = self?.writingView.contentTextView.text

            if let storedString = UIPasteboard.general.string {
                print(storedString)
            }
        }

        writingSubView.alignButtonTapHandler = { [weak self] in
            let alignment = self?.writingView.contentTextView.textAlignment
            if alignment == .left {
                self?.writingView.contentTextView.textAlignment = .center
            } else if alignment == .center {
                self?.writingView.contentTextView.textAlignment = .left
            }
        }

        writingSubView.showTipsButtonTapHandler = { [weak self] in
            let visivlity = self?.tipBox.isHidden ?? false
            self?.tipBox.isHidden = !visivlity
        }
    }

}

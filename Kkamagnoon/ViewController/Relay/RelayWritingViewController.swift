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
    let viewModel = RelayWritingViewModel()

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
        }

    var scrollView = UIScrollView()
        .then {
            $0.showsVerticalScrollIndicator = false
        }

    var relayWritingView = RelayWritingView()

    var writingSubView = WritingSubView()

    var tipBox = TipBox()

    let keyboardShowObserver  = NotificationCenter.default.keyboardWillShowObservable()

    let keyboardHideObserver = NotificationCenter.default.keyboardWillHideObservable()

    private var writingSubViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()

        setKeyBoard()
        setLayout()

        bindInput()
        bindOutput()
        viewModel.bindTips()
    }

}

extension RelayWritingViewController {

    func configureView() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
    }

    func setKeyBoard() {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false

        setAnimateWritingViewGoUp()
        setAnimateWritingViewGoDown()
    }

    func setLayout() {

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

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(8.0)
            $0.bottom.equalTo(writingSubView.snp.top)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        scrollView.addSubview(relayWritingView)
        relayWritingView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-85.0)
        }

        for (index, article) in (viewModel.articleList ?? []).enumerated() {
            let articleCard = RelayWritingCard()
                .then {
                    $0.pageLabel.text = "\(index + 1)"
                    $0.contentLabel.text = article.content
                    $0.setContentHuggingPriority(.required, for: .vertical)
                }
            relayWritingView.relayListStackView.addArrangedSubview(articleCard)
        }

        view.addSubview(tipBox)
        tipBox.snp.makeConstraints {
            $0.height.equalTo(66.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(writingSubView.snp.top).offset(-13.0)
        }

    }

    private func setAnimateWritingViewGoUp() {

        keyboardShowObserver
            .withUnretained(self)
            .bind { owner, keyboardAnimationInfo in
                UIView.animate(withDuration: keyboardAnimationInfo.duration,
                               delay: .zero,
                               options: [UIView.AnimationOptions(rawValue: keyboardAnimationInfo.curve)]) {
                    owner.writingSubViewBottomConstraint.constant = -keyboardAnimationInfo.height
                }
                owner.view.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
    }

    private func setAnimateWritingViewGoDown() {

        keyboardHideObserver
            .withUnretained(self)
            .bind { owner, keyboardAnimationInfo in

                UIView.animate(withDuration: keyboardAnimationInfo.duration,
                               delay: .zero,
                               options: [UIView.AnimationOptions(rawValue: keyboardAnimationInfo.curve)]) {
                    owner.writingSubViewBottomConstraint.constant = -44
                }
                owner.view.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
    }
}

extension RelayWritingViewController {

    func bindInput() {
        header.noticeButton.rx.tap
            .bind(to: viewModel.input.completeButtonTap)
            .disposed(by: disposeBag)

        relayWritingView.contentTextView.rx.text
            .orEmpty
            .bind(to: viewModel.input.contents)
            .disposed(by: disposeBag)
    }

    func bindOutput() {
        viewModel.output.enableCompleteButton
            .asSignal()
            .emit(onNext: setButton)
            .disposed(by: disposeBag)

        viewModel.output.registerWriting
            .asSignal()
            .emit(onNext: goBackToRelayDetail)
            .disposed(by: disposeBag)

        viewModel.output.tips
            .bind(to: tipBox.textLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

extension RelayWritingViewController {
    private func goToTagSelectigVC(articleDTO: CreateArticleDTO ) {
        let vc = ChallengeSelectingTagViewController()
        vc.modalPresentationStyle = .fullScreen

        vc.viewModel.articleDTO = articleDTO
        vc.viewModel.rootView = self.viewModel.rootView

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func setButton(state: Bool) {
        header.noticeButton.isEnabled = state

        if state {
            header.noticeButton.backgroundColor = UIColor(rgb: Color.whitePurple)
        } else {
            // TEMP
            header.noticeButton.backgroundColor = UIColor(rgb: Color.tag)
        }
    }

    private func goBackToRelayDetail(_ article: Article) {
        self.navigationController?.popViewController(animated: false)
    }
}

//
//  BottomSheetViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift
import SnapKit
import RxDataSources
import Then

enum BottomSheetViewState {
    case normal
    case expanded
}

// UISheetPresentationController() 대체
class BottomSheetViewController: UIViewController {

    let viewModel = BottomSheetViewModel()

    let backView = UIView()

    let bottomSheetView = UIView()
        .then {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor(rgb: Color.feedListCard)
        }

    let dragIndicatorView = UIView()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x4B4B4B)
            $0.layer.cornerRadius = 3
        }

    lazy var commentTableView = UITableView()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.feedListCard)
            $0.register(CommentCell.self, forCellReuseIdentifier: CommentCell.commentCellIdentifier)
        }

    let writingCommentView = WritingCommentView()
        .then {
            $0.postingButton.isEnabled = false
            $0.postingButton.setTitleColor(UIColor(rgb: Color.tag), for: .normal)
        }

    let keyboardShowObserver  = NotificationCenter.default.keyboardWillShowObservable()

    let keyboardHideObserver = NotificationCenter.default.keyboardWillHideObservable()

    var actionsheetController: UIAlertController!

    let disposeBag = DisposeBag()

    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Comment>>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withIdentifier: CommentCell.commentCellIdentifier, for: indexPath) as! CommentCell

        cell.commentContent.text = element.content ?? ""
        cell.moreButtonTapHandler = {
            print(">>>TAPP")
            self.showActionView()
        }
        return cell
    })

    private var bottomSheetViewTopConstraint: NSLayoutConstraint!

    var bottomSheetPanMinTopConstant: CGFloat = 0
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    private var writingCommentViewBottomConstraint: NSLayoutConstraint!
    private var keyboardHeight: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyBoard()
        setLayout()
        bindInput()
        bindOutput()

        viewModel.bindComment()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateOpenBottomSheet()
        setDragIndicatorView()
        setCommentTableView()
        setWritingTextView()
        animateWritingViewGoUp()
        animateWritingViewGoDown()
    }
}

extension BottomSheetViewController {

    func bindInput() {
        writingCommentView.textView.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .bind(to: viewModel.input.content)
            .disposed(by: disposeBag)

        writingCommentView.postingButton.rx.tap
            .bind(to: viewModel.input.sendButtonTap)
            .disposed(by: disposeBag)
    }

    func bindOutput() {
        viewModel.output.commentList
            .asDriver()
            .drive(commentTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.output.enableSendButton
            .asDriver()
            .drive(onNext: enableSendButton(_:))
            .disposed(by: disposeBag)
    }

}

extension BottomSheetViewController {
    func setKeyBoard() {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }

    func setLayout() {
        setBackView()
        setBottomSheetView()
    }
}

extension BottomSheetViewController {
    private func setBackView() {
        view.addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        addCloseTapGesture(to: backView)
    }

    private func setBottomSheetView() {
        let topAnchorConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height

        view.addSubview(bottomSheetView)

        bottomSheetView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }

        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.topAnchor)
        bottomSheetViewTopConstraint.isActive = true
        bottomSheetViewTopConstraint.constant = topAnchorConstant

        addClosePanGesture(to: bottomSheetView)
    }

    private func setDragIndicatorView() {
        bottomSheetView.addSubview(dragIndicatorView)
        dragIndicatorView.snp.makeConstraints {
            $0.width.equalTo(74.0)
            $0.height.equalTo(6.0)
            $0.top.equalTo(bottomSheetView).offset(16.0)
            $0.centerX.equalTo(bottomSheetView)
        }
    }

    private func setCommentTableView() {
        bottomSheetView.addSubview(commentTableView)
        commentTableView.snp.makeConstraints {
            $0.top.equalTo(bottomSheetView).offset(21.5)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(view.frame.height - 114 - 110.5)
        }
    }

    private func setWritingTextView() {

        bottomSheetView.addSubview(writingCommentView)
        writingCommentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }

        writingCommentViewBottomConstraint = writingCommentView.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor, constant: -44.0) // 44=65-21
        writingCommentViewBottomConstraint.isActive = true

    }
}

extension BottomSheetViewController {
    private func addCloseTapGesture(to target: UIView) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delaysTouchesBegan = false
        tapGesture.delaysTouchesEnded = false

        target.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .withUnretained(self)
            .bind { owner, _ in

                owner.animateCloseBottomSheet(duration: 0.15)
            }
            .disposed(by: disposeBag)
    }

    private func addClosePanGesture(to target: UIView) {
        let panGesture = UIPanGestureRecognizer()
        target.addGestureRecognizer(panGesture)

        // TODO : 아래로 내리는 팬 액션만 처리하기
        panGesture.rx.event
            .withUnretained(self)
            .bind { owner, _ in
                let translation = panGesture.translation(in: owner.view)
                let topAnchorConstant = owner.view.safeAreaInsets.bottom + owner.view.safeAreaLayoutGuide.layoutFrame.height

                switch panGesture.state {
                case .began:
                    owner.bottomSheetPanStartingTopConstant = owner.bottomSheetViewTopConstraint.constant
                case .changed:
                    if owner.bottomSheetPanStartingTopConstant + translation.y > owner.bottomSheetPanMinTopConstant {

                        owner.bottomSheetViewTopConstraint.constant = owner.bottomSheetPanStartingTopConstant + translation.y
                    }
                case .ended:
                    if owner.bottomSheetViewTopConstraint.constant < topAnchorConstant {
                        owner.hideBottomSheetAndGoBack()
                    }

                default:
                    break
                }

            }
            .disposed(by: disposeBag)
    }
}

extension BottomSheetViewController {
    private func showBottomSheet(atState: BottomSheetViewState = .normal) {
        if atState == .normal {
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
            bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding)
        } else {
            bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
        }

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backView.alpha = 0.7
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }

    func animateOpenBottomSheet() {
        bottomSheetViewTopConstraint.constant = 114

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func animateCloseBottomSheet(duration: CGFloat) {
        let topAnchorConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint.constant = topAnchorConstant

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }

    }

    func animateWritingViewGoUp() {

        keyboardShowObserver
            .bind { [weak self] keyboardAnimationInfo in
                guard let self = self else { return }

                UIView.animate(withDuration: keyboardAnimationInfo.duration,
                               delay: .zero,
                               options: [UIView.AnimationOptions(rawValue: keyboardAnimationInfo.curve)]) {
                    self.writingCommentViewBottomConstraint.constant = -keyboardAnimationInfo.height
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
                    self.writingCommentViewBottomConstraint.constant = -44
                }
                self.view.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
    }

    func showActionView() {
        actionsheetController = UIAlertController()

        let actionDefault = UIAlertAction(title: "수정", style: .default, handler: nil)
        let actionDestructive = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            print("destructive action called")
        })

        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        actionsheetController.addAction(actionDefault)
        actionsheetController.addAction(actionDestructive)
        actionsheetController.addAction(actionCancel)
    }

    private func enableSendButton(_ result: Bool) {
        writingCommentView.postingButton.isEnabled = result
        if result {
            writingCommentView.postingButton.setTitleColor(UIColor(rgb: Color.whitePurple), for: .normal)
        } else {
            writingCommentView.postingButton.setTitleColor(UIColor(rgb: Color.tag), for: .normal)
        }
    }
}

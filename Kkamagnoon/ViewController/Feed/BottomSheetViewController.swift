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

    let dragIndicatorView = UIView()

    lazy var commentTableView = UITableView()

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
    private var writingCommebtViewBottomConstraint: NSLayoutConstraint!
    private var keyboardHeight: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyBoard()
        setBackView()
        setBottomSheetView()
        bind()
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

    func setKeyBoard() {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }

    func setBackView() {
        view.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        addCloseTapGesture(to: backView)
    }

    func setBottomSheetView() {
        view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false

        bottomSheetView.layer.cornerRadius = 10
        bottomSheetView.backgroundColor = UIColor(rgb: Color.feedListCard)

        let topAnchorConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor
            .constraint(equalTo: view.topAnchor,
                        constant: topAnchorConstant)

        bottomSheetViewTopConstraint.isActive = true
        bottomSheetView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomSheetView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        addClosePanGesture(to: bottomSheetView)
    }

    func setDragIndicatorView() {
        bottomSheetView.addSubview(dragIndicatorView)
        dragIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        dragIndicatorView.backgroundColor = UIColor(rgb: 0x4B4B4B)
        dragIndicatorView.layer.cornerRadius = 3

        dragIndicatorView.widthAnchor.constraint(equalToConstant: 74).isActive = true
        dragIndicatorView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        dragIndicatorView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 16).isActive = true
        dragIndicatorView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor).isActive = true
    }

    func setCommentTableView() {
        bottomSheetView.addSubview(commentTableView)
        commentTableView.translatesAutoresizingMaskIntoConstraints = false

        commentTableView.backgroundColor = UIColor(rgb: Color.feedListCard)
        commentTableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.commentCellIdentifier)
        // TODO
        commentTableView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 21.5).isActive = true
        commentTableView.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor).isActive = true
        commentTableView.rightAnchor.constraint(equalTo: bottomSheetView.rightAnchor).isActive = true
        commentTableView.heightAnchor.constraint(equalToConstant: view.frame.height - 114 - 110.5).isActive = true
    }

    func setWritingTextView() {

        bottomSheetView.addSubview(writingCommentView)
        writingCommentView.translatesAutoresizingMaskIntoConstraints = false

        writingCommentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        writingCommentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        // 44=65-21
        writingCommebtViewBottomConstraint = writingCommentView.bottomAnchor
            .constraint(equalTo: view.bottomAnchor, constant: -44)
        writingCommebtViewBottomConstraint.isActive = true

    }

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
//                    let safeAreaHeight = owner.view.safeAreaLayoutGuide.layoutFrame.height
//                    let bottomPadding = owner.view.safeAreaInsets.bottom
//                    let defaultPadding = safeAreaHeight+bottomPadding

//                    let nearestValue = owner.nearest(to: owner.bottomSheetViewTopConstraint.constant, inValues: [owner.bottomSheetPanMinTopConstant, UIScreen.main.bounds.height])

//                    if nearestValue == owner.bottomSheetPanMinTopConstant {
//                        print("Bottom Sheet을 Expanded 상태로 변경하기!")
//                    } else {
//                        owner.hideBottomSheetAndGoBack()
//                    }
                default:
                    break
                }

            }
            .disposed(by: disposeBag)
    }

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
                    self.writingCommebtViewBottomConstraint.constant = -keyboardAnimationInfo.height
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
                    self.writingCommebtViewBottomConstraint.constant = -44
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

}

extension BottomSheetViewController {
    func bind() {

        writingCommentView.textView.rx.text
            .orEmpty
            .bind(to: viewModel.input.content)
            .disposed(by: disposeBag)

        writingCommentView.postingButton.rx.tap
            .bind(to: viewModel.input.sendButtonTap)
            .disposed(by: disposeBag)

        viewModel.output.commentList
            .bind(to: commentTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.output.enableSendButton
            .withUnretained(self)
            .bind { owenr, _ in
                owenr.writingCommentView.postingButton.isEnabled = true
                owenr.writingCommentView.postingButton.setTitleColor(UIColor(rgb: Color.whitePurple), for: .normal)
            }
            .disposed(by: disposeBag)

    }
}

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

// UISheetPresentationController() 대체
class BottomSheetViewController: UIViewController {

    let backView = UIView()
    let bottomSheetView = UIView()

    let dragIndicatorView = UIView()

    lazy var commentTableView = UITableView()

    let writingCommentView = WritingCommentView()

    let disposeBag = DisposeBag()

    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    private var writingCommebtViewBottomConstraint: NSLayoutConstraint!
    private var keyboardHeight: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        setKeyBoard()
        setBackView()
        setBottomSheetView()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateOpenBottomSheet()
        setDragIndicatorView()
        setCommentTableView()
        setWritingTextView()
    }

    func setKeyBoard() {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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
        commentTableView.register(CommentCell.self, forCellReuseIdentifier: CellIdentifier.comment)
        // TODO
        commentTableView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 21.5).isActive = true
        commentTableView.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor).isActive = true
        commentTableView.rightAnchor.constraint(equalTo: bottomSheetView.rightAnchor).isActive = true
        commentTableView.heightAnchor.constraint(equalToConstant: view.frame.height - 114 - 110.5).isActive = true

        // Dummy
        let testString = "내용이 너무 좋아요!!><"
        Observable<[String]>.of([testString, testString, testString])
            .bind(to: commentTableView.rx.items(cellIdentifier: CellIdentifier.comment, cellType: CommentCell.self)) { (_, element, cell) in
                cell.commentContent.text = element
            }
            .disposed(by: disposeBag)
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

        writingCommentView.textView.rx.didBeginEditing
            .bind { _ in
                self.animateWritingViewGoUp()
            }
            .disposed(by: disposeBag)
    }

    private func addCloseTapGesture(to target: UIView) {
        let tapGesture = UITapGestureRecognizer()
        target.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .bind { _ in
                self.animateCloseBottomSheet(duration: 0.15)
            }
            .disposed(by: disposeBag)
    }

    private func addClosePanGesture(to target: UIView) {
        let panGesture = UIPanGestureRecognizer()
        target.addGestureRecognizer(panGesture)

        // TODO : 아래로 내리는 팬 액션만 처리하기
        panGesture.rx.event
            .bind { _ in
                self.animateCloseBottomSheet(duration: 1)
            }
            .disposed(by: disposeBag)
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

        writingCommebtViewBottomConstraint.constant = -keyboardHeight

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func animateWritingViewGoDown() {

        writingCommebtViewBottomConstraint.constant = -44

        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            self.keyboardHeight = keyboardHeight
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        self.animateWritingViewGoDown()
    }

}

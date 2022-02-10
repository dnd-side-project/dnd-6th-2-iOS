//
//  DetailContentViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

class DetailContentViewController: UIViewController {

    lazy var backButton = UIButton()

    lazy var profileView = ProfileView(width: 42, height: 42, fontsize: 15)
    lazy var moreButton = UIButton()
    lazy var updateDateLabel = UILabel()

    lazy var titleLabel: UILabel = UILabel()
    lazy var contentTextView: UITextView = UITextView()

    lazy var bottomView = BottomReactionView()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true
        setBackButton()

        setProfileVeiw()
        setMoreButton()

        setUpdateDateLabel()

        setTitleLabel()
        setContentTextView()
        setBottomView()

        // 안됨..
        bottomView.addBorder(toSide: .top, withColor: UIColor(rgb: 0x545454).cgColor, andThickness: 1.0)
    }

    func setBackButton() {
        backButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.addSubview(backButton)

        backButton.translatesAutoresizingMaskIntoConstraints = false

        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 72).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true

        backButton.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: true)

            }
            .disposed(by: disposeBag)
    }

    func setProfileVeiw() {
        view.addSubview(profileView)

        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 113)
        .isActive = true
        profileView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
    }

    func setMoreButton() {
        moreButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }

    func setUpdateDateLabel() {
        view.addSubview(updateDateLabel)
        updateDateLabel.text = "2022년 2월 1일"
        updateDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        updateDateLabel.textColor = UIColor(rgb: 0x626262)
        updateDateLabel.translatesAutoresizingMaskIntoConstraints = false

        updateDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        updateDateLabel.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 14).isActive = true

    }

    func setTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = "언젠가는"
        view.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.topAnchor.constraint(equalTo: updateDateLabel.bottomAnchor, constant: 17).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true

    }

    func setContentTextView() {
        contentTextView.textColor = .white
        contentTextView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        contentTextView.text = StringType.dummyContents
        contentTextView.isSelectable = false
        contentTextView.isEditable = false
        contentTextView.isUserInteractionEnabled = false
        contentTextView.backgroundColor = .black
        view.addSubview(contentTextView)

        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21).isActive = true
        contentTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }

    func setBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false

        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48).isActive = true
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 45).isActive = true

        bottomView.commentButton.rx.tap
            .bind { _ in
                let vc = BottomSheetViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false, completion: nil)
            }
            .disposed(by: disposeBag)
    }

}

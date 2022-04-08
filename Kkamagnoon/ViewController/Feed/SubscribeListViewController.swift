//
//  SubscribeListViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/09.
//

import UIKit
import RxSwift
import RxCocoa

class SubscribeListViewController: UIViewController {

    let viewModel = SubscribeListViewModel()

    lazy var backButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Back"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 18)
        }

    lazy var pageNameLabel = UILabel()
        .then {
            $0.text = "구독 목록"
            $0.textColor = UIColor(rgb: 0xEFEFEF)

            $0.font = UIFont.pretendard(weight: .medium, size: 20)
        }

    let disposeBag = DisposeBag()

    lazy var listTableView = UITableView()
        .then {
            $0.backgroundColor = .clear
            $0.register(SubscribeListCell.self, forCellReuseIdentifier: SubscribeListCell.subscribeListCellIdentifier)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        navigationController?.isNavigationBarHidden = true

        setLayout()
        bindInput()
        bindOutput()

    }

}

extension SubscribeListViewController {
    func setLayout() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(72.0)
            $0.left.equalToSuperview().offset(25.0)
        }

        view.addSubview(pageNameLabel)
        pageNameLabel.snp.makeConstraints {
            $0.left.equalTo(backButton.snp.right).offset(16.87)
            $0.centerY.equalTo(backButton)
        }

        view.addSubview(listTableView)
        listTableView.snp.makeConstraints {
            $0.top.equalTo(pageNameLabel.snp.bottom).offset(26.0)
            $0.left.equalToSuperview().offset(24.0)
            $0.right.equalToSuperview().offset(-24.0)
            $0.bottom.equalToSuperview().offset(-20.0)
        }

    }

    func bindInput() {
        backButton.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: true)

            }
            .disposed(by: disposeBag)

        Observable<[String]>.of(["오리부리", "지그재그", "abcd", "감자튀김", "닉주디", "I_need"])
            .bind(to: listTableView.rx.items(cellIdentifier: SubscribeListCell.subscribeListCellIdentifier, cellType: SubscribeListCell.self)) { (_: Int, element: String, cell: SubscribeListCell) in

                cell.profileView.nickNameLabel.text = element

            }
            .disposed(by: disposeBag)
    }

    func bindOutput() {

    }
}

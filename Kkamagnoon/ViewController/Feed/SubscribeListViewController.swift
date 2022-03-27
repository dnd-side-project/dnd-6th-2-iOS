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

    lazy var backButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Back"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 18)
        }
    lazy var pageNameLabel = UILabel()

    let disposeBag = DisposeBag()

    lazy var listTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        navigationController?.isNavigationBarHidden = true
        setBackButton()
        setPageNameLabel()
        setListTableView()
    }

    func setBackButton() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        backButton.setImage(UIImage(systemName: "Back"), for: .normal)
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 72).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true

        backButton.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: true)

            }
            .disposed(by: disposeBag)
    }

    func setPageNameLabel() {
        view.addSubview(pageNameLabel)

        pageNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pageNameLabel.text = "구독 목록"
        pageNameLabel.textColor = UIColor(rgb: 0xEFEFEF)

        pageNameLabel.font = UIFont.pretendard(weight: .medium, size: 20)

        pageNameLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 16.87).isActive = true
        pageNameLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
    }

    func setListTableView() {
        listTableView.backgroundColor = UIColor(rgb: Color.basicBackground)
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false

        listTableView.register(SubscribeListCell.self, forCellReuseIdentifier: SubscribeListCell.subscribeListCellIdentifier)

        listTableView.topAnchor.constraint(equalTo: pageNameLabel.bottomAnchor, constant: 26).isActive = true
        listTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        listTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -23).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

        Observable<[String]>.of(["오리부리", "지그재그", "abcd", "감자튀김", "닉주디", "I_need"])
            .bind(to: listTableView.rx.items(cellIdentifier: SubscribeListCell.subscribeListCellIdentifier, cellType: SubscribeListCell.self)) { (_: Int, element: String, cell: SubscribeListCell) in

                cell.profileView.nickNameLabel.text = element

            }
            .disposed(by: disposeBag)
    }

}

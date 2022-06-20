//
//  ParticipantViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class ParticipantViewController: BaseViewController {

    var disposeBag = DisposeBag()

    let backView = UIView()
        .then {
            $0.backgroundColor = .clear
        }

    let participantView = ParticipantListView()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x2A2A2A)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        setLayout()

    }

    func setLayout() {

        view.addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(participantView)
        participantView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width * (316/395))
            $0.top.right.bottom.equalToSuperview()
        }

        // 수정 필요
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismiss(animated: false, completion: nil)
            }
            .disposed(by: disposeBag)

        // DUMMY
        Observable<[String]>.of(["오리부리", "지그재그", "abcd", "감자튀김", "닉주디", "I_need"])
            .bind(to: participantView.tableView.rx.items(cellIdentifier: ParticipantCell.participantCellIdentifier, cellType: ParticipantCell.self)) { (_: Int, element: String, cell: ParticipantCell) in

                cell.profileView.nickNameLabel.text = element

            }
            .disposed(by: disposeBag)
    }

}

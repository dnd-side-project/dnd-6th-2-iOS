//
//  RelayViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit
import Then
import SnapKit
import RxSwift

class RelayViewController: UIViewController {

    var disposeBag = DisposeBag()

    lazy var topButtonView = TopButtonView(frame: .zero, first: StringType.relayRoom, second: StringType.joinedRoom)
        .then { topView in
            topView.searchButton.isHidden = true
            topView.secondButton.snp.makeConstraints {
                $0.left.equalTo(topView.firstButton.snp.right).offset(12.0)
            }
        }

    lazy var relayRoomView = RelayRoomView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setView()

    }

    func setView() {
        view.addSubview(topButtonView)
        topButtonView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(115.0)
        }

        view.addSubview(relayRoomView)

        relayRoomView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topButtonView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        relayRoomView.relayList.collectionView.rx.itemSelected
            .bind { _ in

                let vc = RelayDetailViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)

    }

}

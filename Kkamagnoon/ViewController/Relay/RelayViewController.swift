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
import RxCocoa

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

    lazy var makingRoomButton = MakingRoomButton()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setView()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makingRoomButton.layer.cornerRadius = makingRoomButton.frame.size.width / 2
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

        view.addSubview(makingRoomButton)
        makingRoomButton.snp.makeConstraints {
            $0.size.equalTo(55.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14.0)
        }

        makingRoomButton.rx.tap
            .bind {
                let vc = MakingRelayRoomViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.hidesBottomBarWhenPushed = true

                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)

    }

}

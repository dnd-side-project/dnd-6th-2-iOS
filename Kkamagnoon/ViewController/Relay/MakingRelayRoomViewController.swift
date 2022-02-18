//
//  MakingRelayRoomViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class MakingRelayRoomViewController: UIViewController {

    var disposeBag = DisposeBag()
    let viewModel = MakingRelayRoomModel()

    var scrollView = UIScrollView()
          .then {
              $0.showsVerticalScrollIndicator = false

          }

    var makingRelayView = MakingRelayView()

    var enterButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x242424)
            $0.setTitle("시작하기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 18)
            $0.setTitleColor(UIColor(rgb: 0xA0A0A0), for: .normal)
            $0.layer.cornerRadius = 10
            $0.isEnabled = false
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)

        setView()
        bindView()
    }

    func setView() {

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

        scrollView.addSubview(makingRelayView)

        makingRelayView.snp.makeConstraints {
            $0.width.equalToSuperview()

            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        view.addSubview(enterButton)
        enterButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-40.0)
            $0.height.equalTo(56.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40.0)
        }

    }

    func bindView() {
        // Input
        makingRelayView.textViewList[0].rx.text
            .orEmpty
            .bind(to: viewModel.input.title)
            .disposed(by: disposeBag)

        makingRelayView.textViewList[1].rx.text
            .orEmpty
            .bind(to: viewModel.input.notice)
            .disposed(by: disposeBag)

        enterButton.rx.tap
            .bind(to: viewModel.input.startButtonTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.enableStartButton
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isEnable in
                self?.enableEnterButton(isEnable: isEnable)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToNewRelay
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToNewRelay()
            }
            .disposed(by: disposeBag)
    }

    private func enableEnterButton(isEnable: Bool) {
        if isEnable {
            enterButton.isEnabled = true
            enterButton.backgroundColor = UIColor(rgb: Color.whitePurple)
            enterButton.setTitleColor(.white, for: .normal)
        } else {
            enterButton.isEnabled = false
            enterButton.backgroundColor = UIColor(rgb: 0x242424)
            enterButton.setTitleColor(UIColor(rgb: 0xA0A0A0), for: .normal)
        }
    }

    private func goToNewRelay() {
        let vc = RelayDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.isNew = true

        self.navigationController?.popViewController(animated: true) {
            self.viewModel.rootView?.navigationController?.pushViewController(vc, animated: true)
        }

    }

}

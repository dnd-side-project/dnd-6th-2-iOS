//
//  RelayDetailViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class RelayDetailViewController: UIViewController {

    var disposeBag = DisposeBag()

    var detailView = RelayDetailView()
    let viewModel = RelayDetailViewModel()

    var enterButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
            $0.setTitle("방 입장하기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 18)
            $0.setTitleColor(UIColor(rgb: 0xF0F0F0), for: .normal)
            $0.layer.cornerRadius = 10
        }

    var bottomBar = BottomBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true

        setDetailView()

        if viewModel.isNew {
            setBottomBar()
        } else {
            setEnterButton()
        }
        bindView()
    }

    func setDetailView() {
        view.addSubview(detailView)

        detailView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }

    func setEnterButton() {
        view.addSubview(enterButton)

        enterButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-40.0)
            $0.height.equalTo(56.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40.0)
        }
    }

    func setBottomBar() {
        view.addSubview(bottomBar)

        bottomBar.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(70.0)
        }
    }

    func bindView() {
        // Input
        enterButton.rx.tap
            .bind(to: viewModel.input.enterButtonTap)
            .disposed(by: disposeBag)

        bottomBar.participantButton.rx.tap
            .bind(to: viewModel.input.participantButtonTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.goToRoom
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToPopUpVC()
            }
            .disposed(by: disposeBag)

        viewModel.output.goToParticipantView
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToParticipationVC()
            }
            .disposed(by: disposeBag)
    }

    private func goToPopUpVC() {
        let vc = PopUpViewController()
        vc.viewModel.output.relayDetailViewStyle
            .withUnretained(self)
            .bind { owner, style in
                if style == .nonParticipation {
                    owner.bottomBar.removeFromSuperview()
                    owner.setEnterButton()
                } else {
                    owner.enterButton.removeFromSuperview()
                    owner.setBottomBar()
                }
            }
            .disposed(by: disposeBag)
        vc.modalPresentationStyle = .overFullScreen

        self.present(vc, animated: false)
    }

    private func goToParticipationVC() {
        let vc = ParticipantViewController()
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: false, completion: nil)
    }

}

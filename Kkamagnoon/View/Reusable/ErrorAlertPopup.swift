//
//  ErrorAlertPopup.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/05/18.
//

import UIKit
import Then
import SnapKit
import RxSwift

class ErrorAlertPopup: UIView {

    private static var sharedView: ErrorAlertPopup!
    var disposeBag = DisposeBag()

    let box = UIView()
        .then {
            $0.backgroundColor = UIColor.appColor(.alertBoxGray)
            $0.layer.cornerRadius = 14.4
        }

    var icon = UIImageView()
        .then {
            $0.image = UIImage(systemName: "heart.fill")
        }

    var titleLabel = UILabel()
        .then {
            $0.text = "네트워크 연결에 실패했습니다"
            $0.font = UIFont.pretendard(weight: .bold, size: 18.0)
            $0.textColor = .white
        }

    var contentLabel = UILabel()
        .then {
            $0.text = "인터넷이 원활하지 않습니다\n 인터넷 연결을 다시 확인해주세요"
            $0.numberOfLines = 0
            $0.lineBreakMode = .byTruncatingTail
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(weight: .medium, size: 16.0)
            $0.textColor = UIColor.appColor(.feedBoxWhite)
        }

    var okayButton = UIButton()
        .then {
            $0.backgroundColor = UIColor.appColor(.mainPurple)
            $0.setTitle("확인", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 18.0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 6.72
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        layoutView()
        bindButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        layoutView()
        bindButton()
    }

}

extension ErrorAlertPopup {

    private func configureView() {
        self.backgroundColor = .init(white: 0, alpha: 0.3)
    }

    private func layoutView() {

        self.addSubview(box)
        box.snp.makeConstraints {
            $0.width.equalTo(316)
            $0.center.equalToSuperview()
        }

        box.addSubview(icon)
        icon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(19.0)
        }

        box.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(icon.snp.bottom).offset(15.5)
        }

        box.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(11.06)
            $0.centerX.equalToSuperview()
        }

        box.addSubview(okayButton)
        okayButton.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(21)
            $0.left.equalToSuperview().offset(16.0)
            $0.right.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-16.0)
            $0.height.equalTo(46.0)
        }

    }

    private func bindButton() {
        okayButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.removeFromSuperview()
            }
            .disposed(by: disposeBag)
    }

    static func showIn(viewController: UIViewController, message: String) {
        var displayVC = viewController

        if let tabController = viewController as? UITabBarController {
            displayVC = tabController.selectedViewController ?? viewController
        }

        if sharedView == nil {
            sharedView = ErrorAlertPopup()
        }

        sharedView.titleLabel.text = message

        displayVC.view.addSubview(sharedView)
        sharedView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }

    }
}

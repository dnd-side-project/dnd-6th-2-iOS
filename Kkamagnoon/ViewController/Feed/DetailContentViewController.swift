//
//  DetailContentViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

import Then
import SnapKit

class DetailContentViewController: UIViewController {

    var stackView = UIStackView()
          .then {
              $0.axis = .vertical
              $0.spacing = 0
              $0.alignment = .fill
              $0.distribution = .fill
          }

    var scrollView = UIScrollView()
          .then {
              $0.showsVerticalScrollIndicator = false
              $0.setContentHuggingPriority(.defaultLow, for: .vertical)
          }

    var bottomView = BottomReactionView()
        .then {
            $0.frame.size.height = 45
            $0.setContentHuggingPriority(.required, for: .vertical)
        }

    var detailView = DetailView()
        .then {
            $0.sizeToFit()
        }

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true

        setView()
        layoutView()

//        // 회색선 넣기 안됨..
//        bottomView.addBorder(toSide: .top, withColor: UIColor(rgb: 0x545454).cgColor, andThickness: 1.0)
    }

    func setView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(scrollView)
        stackView.addArrangedSubview(bottomView)

        scrollView.addSubview(detailView)

        bottomView.commentButton.rx.tap
            .bind { _ in
                let vc = BottomSheetViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false, completion: nil)
            }
            .disposed(by: disposeBag)
    }

    func layoutView() {
        stackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        scrollView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }

        bottomView.snp.makeConstraints {
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(-48.0)
        }

        detailView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }

}

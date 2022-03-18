//
//  SuccessPopUpViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class SuccessPopUpViewController: UIViewController {

    var disposeBag = DisposeBag()
    let viewModel = PopUpViewModel()

    var backView = UIView()
        .then {
            $0.backgroundColor = UIColor(rgb: 0x1C1C1C)
            $0.alpha = 0.8
        }

    var popUpView = PopUpView()
        .then {
            $0.alertTitleLabel.text = "챌린지 완료!"
            $0.contentLabel.text = "오늘의 챌린지를 완료 했어요!\n오늘로 n개의 스탬프를 찍었어요"
            $0.subContentLabel.isHidden = true
            $0.stackView.removeArrangedSubview($0.exitButton)
            $0.enterButton.setTitle("확인", for: .normal)
        }
    var imageView = UIImageView()
        .then {
            $0.image = UIImage(named: "CompletedCharacter")
            $0.contentMode = .scaleAspectFit
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setView()
        bindView()
    }
}

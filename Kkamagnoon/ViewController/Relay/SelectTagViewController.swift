//
//  SelectTagViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class SelectTagViewController: UIViewController {

    var disposeBag = DisposeBag()
    let viewModel = SelectTagViewModel()

    var scrollView = UIScrollView()
          .then {
              $0.showsVerticalScrollIndicator = false
          }

    var backButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    var titleLabel = UILabel()
        .then {
            $0.text = "글의 태그를\n선택 해주세요."
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont.pretendard(weight: .medium, size: 22)
            $0.textColor = .white
        }

    var subTitleLabel = UILabel()
        .then {
            $0.text = "태그는 최대 6개까지 선택할 수 있어요."
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.textColor = UIColor(rgb: 0xB0B0B0)
        }

    var tagStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 21
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }

    var tagPair: [PairView] = [
        PairView().then {
            $0.firstTag.categoryLabel.text = "일상"
            $0.secondTag.categoryLabel.text = "로맨스"
        },
        PairView().then {
            $0.firstTag.categoryLabel.text = "추리"
            $0.secondTag.categoryLabel.text = "코믹"
        },
        PairView().then {
            $0.firstTag.categoryLabel.text = "감성"
            $0.secondTag.categoryLabel.text = "시"
        },
        PairView().then {
            $0.firstTag.categoryLabel.text = "소설"
            $0.secondTag.categoryLabel.text = "글귀"
        },
        PairView().then {
            $0.firstTag.categoryLabel.text = "일기"
            $0.secondTag.categoryLabel.text = "수필"
        },
        PairView().then {
            $0.firstTag.categoryLabel.text = "짧은 글"
            $0.secondTag.categoryLabel.text = "긴 글"
        }
    ]

    var completeButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
            $0.setTitle("완료하기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 18)
            $0.setTitleColor(UIColor(rgb: 0xF0F0F0), for: .normal)
            $0.layer.cornerRadius = 10
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
        setScrollView()
        setBackButton()
        setTitleLabel()
        setSubTitleLabel()
        setTagStackView()
        setCompleteButton()
        bindView()
    }

    func setScrollView() {
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setBackButton() {

        scrollView.addSubview(backButton)

        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(21.0)
            $0.top.equalToSuperview().offset(26.24)
        }

        backButton.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    func setTitleLabel() {
        scrollView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(21.0)
            $0.left.equalToSuperview().offset(23.0)
            $0.right.equalToSuperview().offset(-23.0)
        }

    }

    func setSubTitleLabel() {
        scrollView.addSubview(subTitleLabel)

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17.0)
            $0.left.equalToSuperview().offset(23.0)
            $0.right.equalToSuperview().offset(-23.0)
        }
    }

    func setTagStackView() {
        scrollView.addSubview(tagStackView)

        for tag in tagPair {
            tagStackView.addArrangedSubview(tag)
        }

        tagStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(28.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }

    }

    func setCompleteButton() {
        view.addSubview(completeButton)

        completeButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-40.0)
            $0.height.equalTo(56.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40.0)
        }
    }

    func bindView() {
        completeButton.rx.tap
            .bind(to: viewModel.input.completeButtonTap)
            .disposed(by: disposeBag)

        viewModel.output.goBackToMakingView
            .withUnretained(self)
            .bind { owner, _ in
                owner.popBack()
            }
            .disposed(by: disposeBag)
    }

    private func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

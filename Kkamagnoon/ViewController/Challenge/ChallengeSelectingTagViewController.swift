//
//  ChallengeSelectingTagViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/25.
//

import UIKit
import SnapKit
import Then
import RxDataSources
import RxSwift
import RxCocoa

class ChallengeSelectingTagViewController: UIViewController {

    var disposeBag = DisposeBag()
    let viewModel = ChallengeSelectingTagViewModel()

    var backButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Back"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 18)
        }

    var scrollView = UIScrollView()

    var selectTagView = SelectTagView()

    var stackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }

    var tempSaveButton = UIButton()
        .then {
            $0.setTitle("임시보관하기", for: .normal)
            $0.setTitleColor(UIColor(rgb: 0xF0F0F0), for: .normal)
            $0.backgroundColor = UIColor(rgb: 0x3F3F3F)
            $0.titleLabel?.font = UIFont.pretendard(weight: .regular, size: 18)
            $0.layer.cornerRadius = 10
        }

    var completeButton = UIButton()
        .then {
            $0.setTitle("게시하기", for: .normal)
            $0.setTitleColor(UIColor(rgb: 0xF0F0F0), for: .normal)
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
            $0.titleLabel?.font = UIFont.pretendard(weight: .regular, size: 18)
            $0.layer.cornerRadius = 10
        }

    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectingTagCell.selectingTagCellIdentifier, for: indexPath) as! SelectingTagCell

        cell.tagView.categoryLabel.text = element

        return cell
    }, configureSupplementaryView: { _, collectionView, _, indexPath in
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectingCollectionReusableView.identifier, for: indexPath) as! SelectingCollectionReusableView

        return headerView
    })

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        setView()
        bindView()
    }
}

extension ChallengeSelectingTagViewController {
    func setView() {

        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(21.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(26.24)
        }

        view.addSubview(stackView)
        stackView.addArrangedSubview(tempSaveButton)
        stackView.addArrangedSubview(completeButton)

        stackView.snp.makeConstraints {

            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview().offset(-42.0)
            $0.height.equalTo(54.0)
        }

        view.addSubview(selectTagView)
        Observable.just([SectionModel(model: "title", items: StringType.categories)])
            .bind(to: selectTagView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        selectTagView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(backButton.snp.bottom)
            $0.bottom.equalTo(stackView.snp.top).offset(-20)
        }
    }
}

extension ChallengeSelectingTagViewController {
    func bindView() {
        // Input
        backButton.rx.tap
            .bind(to: viewModel.input.backButtonTap)
            .disposed(by: disposeBag)

        selectTagView.collectionView.rx
            .modelSelected(String.self)
            .bind(to: viewModel.input.tagTap)
            .disposed(by: disposeBag)

        tempSaveButton.rx.tap
            .bind(to: viewModel.input.tempSaveButtonTap)
            .disposed(by: disposeBag)

        completeButton.rx.tap
            .bind(to: viewModel.input.completeButtonTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.goToMainView
            .withUnretained(self)
            .bind { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToMainView
            .withUnretained(self)
            .bind { owner, _ in
                owner.navigationController?.popToRootViewController(animated: false)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToMainViewAndPopUp
            .withUnretained(self)
            .bind { owner, _ in
                owner.navigationController?.popToRootViewController(animated: false, completion: {
                    let vc = SuccessPopUpViewController()

                    owner.viewModel.rootView?.present(vc, animated: false, completion: nil)
                })

            }
            .disposed(by: disposeBag)
    }
}

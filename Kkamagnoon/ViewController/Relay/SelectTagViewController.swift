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
import RxDataSources

class SelectTagViewController: UIViewController {

    var disposeBag = DisposeBag()
    let viewModel = SelectTagViewModel()

    var backButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectingTagCell.selectingTagCellIdentifier, for: indexPath) as! SelectingTagCell

        cell.tagView.categoryLabel.text = element

        return cell
    }, configureSupplementaryView: { _, collectionView, _, indexPath in
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectingCollectionReusableView.identifier, for: indexPath) as! SelectingCollectionReusableView

        return headerView
    })

    var completeButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
            $0.setTitle("완료하기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 18)
            $0.setTitleColor(UIColor(rgb: 0xF0F0F0), for: .normal)
            $0.layer.cornerRadius = 10
        }

    var selectTagView = SelectTagView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true

        setBackButton()

        setCompleteButton()
        setSelectTagView()
        bindView()
    }

    func setBackButton() {

        view.addSubview(backButton)

        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(21.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(26.24)
        }
    }

    func setSelectTagView() {
        view.addSubview(selectTagView)

        selectTagView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(backButton.snp.bottom)
            $0.bottom.equalTo(completeButton.snp.top).offset(-20.0)
        }

        Observable.just([SectionModel(model: "title", items: viewModel.tagList)])
            .bind(to: selectTagView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
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

        backButton.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        completeButton.rx.tap
            .bind(to: viewModel.input.completeButtonTap)
            .disposed(by: disposeBag)

//        selectTagView.collectionView.rx.modelSelected(String.self)
//            .withUnretained(self)
//            .bind { owner, model in
//                
////                owner.viewModel.selectedState[indexPath.row] = true
////                owner.viewModel.selectedTags.append(owner.viewModel.tagList[indexPath.row])
//            }
//            .disposed(by: disposeBag)

        viewModel.output.goBackToMakingView
            .withUnretained(self)
            .bind { owner, _ in
                owner.popBack()
            }
            .disposed(by: disposeBag)
    }

    private func setHandler(tagView: TagView, tag: String) {
        tagView.tapHandler = { [unowned self] in

            if viewModel.selectedTags.count < 6 {
                viewModel.selectedTags.append(tag)

            }
        }
    }

    private func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

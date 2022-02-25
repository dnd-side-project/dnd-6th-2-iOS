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
import RxDataSources

class MakingRelayRoomViewController: UIViewController {

    var disposeBag = DisposeBag()
    var viewModel = MakingRelayRoomModel()

    var scrollView = UIScrollView()
          .then {
              $0.showsVerticalScrollIndicator = false

          }

    var makingRelayView = MakingRelayView()
        .then {
            $0.addingTagView.collectionView.register(
                AddingTagCell.self,
                forCellWithReuseIdentifier: AddingTagCell.identifier
            )
        }

    var tagDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>> { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddingTagCell.identifier,
            for: indexPath) as! AddingTagCell

        cell.tagView.categoryLabel.text = element

        if element == StringType.addTagString {
            cell.tagView.backgroundColor = UIColor(rgb: Color.tag)

            if indexPath.row != 0 {
                cell.tagView.categoryLabel.text = "+"
            }
        }

        return cell
    }

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
        viewModel.bindTagList()
    }

    func setView() {

        view.addSubview(enterButton)
        enterButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-40.0)
            $0.height.equalTo(56.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40.0)
        }

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(enterButton.snp.top).offset(-10.0)
        }

        scrollView.addSubview(makingRelayView)

        makingRelayView.snp.makeConstraints {
            $0.width.equalToSuperview()

            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

    }

    func bindView() {
        // Input
        makingRelayView.backButton
            .rx.tap
            .bind(to: viewModel.input.backButtonTap)
            .disposed(by: disposeBag)

        makingRelayView.addingTagView.collectionView
            .rx.modelSelected(String.self)
            .bind(to: viewModel.input.addingTagButtonTap)
            .disposed(by: disposeBag)

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

        makingRelayView.settingPersonnelView.minusButton
            .rx.tap
            .bind(to: viewModel.input.minusButtonTap)
            .disposed(by: disposeBag)

        makingRelayView.settingPersonnelView.plusButton
            .rx.tap
            .bind(to: viewModel.input.plusButtonTap)
            .disposed(by: disposeBag)

        // Output

        viewModel.output.tagList
            .bind(to: makingRelayView.addingTagView.collectionView
                    .rx.items(dataSource: tagDataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToSelectTag
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToSelectTagVC()
            }
            .disposed(by: disposeBag)

        viewModel.output.enableStartButton
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isEnable in
                self?.enableEnterButton(isEnable: isEnable)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToNewRelay
            .withUnretained(self)
            .bind { owner, relay in
                owner.goToNewRelay(relay: relay)
            }
            .disposed(by: disposeBag)

        viewModel.output.personnelCount
            .withUnretained(self)
            .bind { owner, count in
                owner.makingRelayView.settingPersonnelView
                    .personnelLabel.text = "\(count)명"
            }
            .disposed(by: disposeBag)
    }

    private func goToSelectTagVC() {

        let vc = SelectTagViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.output.tagList
            .bind(to: viewModel.input.originalTagList)
            .disposed(by: disposeBag)

        self.navigationController?.pushViewController(vc, animated: true)
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

    private func goToNewRelay(relay: Relay) {
        let vc = RelayDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.isNew = true

        Observable<Relay>.just(relay)
            .bind(to: vc.viewModel.input.relayInfo)
            .disposed(by: disposeBag)

        self.navigationController?.popViewController(animated: true) {
            self.viewModel.rootView?.navigationController?.pushViewController(vc, animated: true)
        }

    }

}

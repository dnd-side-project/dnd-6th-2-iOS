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
import RxDataSources

class RelayViewController: UIViewController {

    let viewModel = RelayViewModel()
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

    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier, for: indexPath) as! RelayRoomCell
        cell.layer.cornerRadius = 15.0
        cell.contentLabel.text = element
        cell.tagListView.tagList = ["태그1", "태그2", "태그태그", "태", "태그그그그"]
        cell.tagListView.setTags()

        return cell
    },
    configureSupplementaryView: { _, collectionView, _, indexPath in
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SortHeaderCell.sortHeaderCellReuseIdentifier, for: indexPath) as! SortHeaderCell

        headerView.buttonTappedHandler = { [unowned self] in
            if self.viewModel.sortStyle == .byLatest {
                headerView.sortButton.setTitle("인기순", for: .normal)
                self.viewModel.sortStyle = .byPopularity
            } else {
                headerView.sortButton.setTitle("최신순", for: .normal)
                self.viewModel.sortStyle = .byLatest
            }
        }

        return headerView
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setView()
        bindView()

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

        view.addSubview(makingRoomButton)
        makingRoomButton.snp.makeConstraints {
            $0.size.equalTo(55.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14.0)
        }
    }

    func bindView() {
        // Input
        topButtonView.firstButton.rx.tap
            .bind(to: viewModel.input.relayRoomButtonTap)
            .disposed(by: disposeBag)

        topButtonView.secondButton.rx.tap
            .bind(to: viewModel.input.participatedRoomButtonTap)
            .disposed(by: disposeBag)

        relayRoomView.categoryFilterView.filterView.allowsMultipleSelection = true
        relayRoomView.categoryFilterView.filterView
            .rx.itemSelected
            .withUnretained(self)
            .bind { owner, _ in
                print(">>>SELECTED!!")
                owner.viewModel.selectedTagCount += 1
            }
            .disposed(by: disposeBag)

//        relayRoomView.relayList.collectionView
//            .supplementaryView(
//                forElementKind: UICollectionView.elementKindSectionHeader,
//                               at: IndexPath(item: 0, section: 0))?
//            .isUserInteractionEnabled = true

        relayRoomView.relayList.collectionView.rx.itemSelected
            .bind(to: viewModel.input.relayRoomCellTap)
            .disposed(by: disposeBag)

        makingRoomButton.rx.tap
            .bind(to: viewModel.input.makingRoomButtonTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.currentListStyle
            .withUnretained(self)
            .bind { owner, style in
                owner.changeListStyle(style: style)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToBell
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToBellNoticeViewController()
            }
            .disposed(by: disposeBag)

        viewModel.output.relayRoomList
            .bind(to: relayRoomView.relayList.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToDetailRelayRoom
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToRelayDetailViewController()
            }
            .disposed(by: disposeBag)

        viewModel.output.goToMakingRelay
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToMakingRelayViewController()
            }
            .disposed(by: disposeBag)
    }

    private func changeListStyle(style: RelayListStyle) {

    }

    private func goToBellNoticeViewController() {

    }

    private func goToRelayDetailViewController() {
        let vc = RelayDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToMakingRelayViewController() {
        let vc = MakingRelayRoomViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.rootView = self

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

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

class RelayViewController: BaseViewController {

    let viewModel = RelayViewModel()
    var disposeBag = DisposeBag()

    var roomView: UIView!

    lazy var topButtonView = TopButtonView(frame: .zero, first: StringType.relayRoom, second: StringType.joinedRoom)
        .then { topView in
            topView.searchButton.isHidden = true
            topView.secondButton.snp.makeConstraints {
                $0.left.equalTo(topView.firstButton.snp.right).offset(12.0)
            }
        }

    var relayRoomView = RelayRoomView()
        .then {
            $0.categoryFilterView.filterView
                .register(CategoryFilterCell.self,
                          forCellWithReuseIdentifier: CategoryFilterCell.categoryFilterCellIdentifier)
        }

    var participatedRoomView = ParticipatedRoomView()

    var makingRoomButton = MakingRoomButton()
        .then {
            $0.setImage(UIImage(named: "Pencil"), for: .normal)
        }

    lazy var relayRoomDataSource = RxCollectionViewSectionedReloadDataSource<RelaySection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier, for: indexPath) as! RelayRoomCell

        self.setRelayRoomCell(cell: cell, element: element, indexPath: indexPath)

        return cell
    },
    configureSupplementaryView: { _, collectionView, _, indexPath in
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SortHeaderCell.sortHeaderCellReuseIdentifier, for: indexPath) as! SortHeaderCell

        headerView.buttonTappedHandler = { [unowned self] in
            if self.viewModel.output.currentSortStyle.value == .byLatest {
                headerView.sortButton.setTitle("인기순", for: .normal)
                self.viewModel.output.currentSortStyle.accept(.byPopularity)
            } else {
                headerView.sortButton.setTitle("최신순", for: .normal)
                self.viewModel.output.currentSortStyle.accept(.byLatest)
            }

        }

        return headerView
    })

    lazy var participatedRoomDataSource = RxCollectionViewSectionedReloadDataSource<RelaySection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier, for: indexPath) as! RelayRoomCell

        cell.profileView.nickNameLabel.text = element.title
        cell.contentLabel.text = element.notice?.notice
        cell.tagListView.tagList = element.tags ?? []

        cell.tagListView.setTags(tagViewColor: 0x4B4B4B, tagTextColor: 0xFFFFFF)
        return cell
    })

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setLayout()
        bindInput()
        bindOutput()
        viewModel.bindRelayList()
        viewModel.bindParticipatedRoomList()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makingRoomButton.layer.cornerRadius = makingRoomButton.frame.size.width / 2
    }
}

extension RelayViewController {

    func configureView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        roomView = relayRoomView
    }

    func setLayout() {
        view.addSubview(topButtonView)
        topButtonView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(115.0)
        }

        view.addSubview(makingRoomButton)
        makingRoomButton.snp.makeConstraints {
            $0.size.equalTo(55.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14.0)
        }

        setRoomView()
    }

    func setRoomView() {
        view.addSubview(roomView)

        roomView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topButtonView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        view.bringSubviewToFront(makingRoomButton)
    }

    func bindInput() {
        topButtonView.firstButton.rx.tap
            .bind(to: viewModel.input.relayRoomButtonTap)
            .disposed(by: disposeBag)

        topButtonView.secondButton.rx.tap
            .bind(to: viewModel.input.participatedRoomButtonTap)
            .disposed(by: disposeBag)

        topButtonView.bellButton.rx.tap
            .bind(to: viewModel.input.bellButtonTap)
            .disposed(by: disposeBag)

        relayRoomView.categoryFilterView.filterView
            .rx.modelSelected(String.self)
            .bind(to: viewModel.input.tagCellTap)
            .disposed(by: disposeBag)

        relayRoomView.categoryFilterView.filterView
            .rx.modelDeselected(String.self)
            .bind(to: viewModel.input.tagCellTap)
            .disposed(by: disposeBag)

        relayRoomView.relayList.collectionView.rx
            .modelSelected(Relay.self)
            .bind(to: viewModel.input.relayRoomCellTap)
            .disposed(by: disposeBag)

        participatedRoomView.relayList.collectionView.rx
            .modelSelected(Relay.self)
            .bind(to: viewModel.input.relayRoomCellTap)
            .disposed(by: disposeBag)

        makingRoomButton.rx.tap
            .bind(to: viewModel.input.makingRoomButtonTap)
            .disposed(by: disposeBag)
    }

    func bindOutput() {

        viewModel.output.currentListStyle
            .asDriver()
            .drive(onNext: changeRoomStyle)
            .disposed(by: disposeBag)

        viewModel.output.goToBell
            .asSignal()
            .emit(onNext: goToBellNoticeViewController)
            .disposed(by: disposeBag)

        // relay room
        viewModel.output.tagList
            .asDriver(onErrorJustReturn: StringType.categories)
            .drive(relayRoomView.categoryFilterView.filterView.rx.items(
                cellIdentifier: CategoryFilterCell.categoryFilterCellIdentifier,
                cellType: CategoryFilterCell.self)) { (_, element, cell) in
                    cell.tagView.categoryLabel.text = element
                }
                .disposed(by: disposeBag)

        viewModel.output.relayRoomList
            .asDriver()
            .drive(relayRoomView.relayList.collectionView
                    .rx.items(dataSource: relayRoomDataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToDetailRelayRoom
            .asSignal()
            .emit(onNext: goToRelayDetailViewController)
            .disposed(by: disposeBag)

        // participated room
        viewModel.output.participatedRoomList
            .asDriver()
            .drive(participatedRoomView.relayList.collectionView
                    .rx.items(dataSource: participatedRoomDataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToMakingRelay
            .asSignal()
            .emit(onNext: goToMakingRelayViewController)
            .disposed(by: disposeBag)

        viewModel.output.showError
            .asSignal()
            .emit(onNext: showError)
            .disposed(by: disposeBag)
    }
}

extension RelayViewController {
    private func goToBellNoticeViewController() {
        let vc = BellNoticeViewController()
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToRelayDetailViewController(relay: Relay) {
        let vc = RelayDetailViewController()
        vc.viewModel.relayInfo = relay

        if viewModel.output.currentListStyle.value == .relayRoom {
            vc.viewModel.didEntered = false
        } else {
            vc.viewModel.didEntered = true
        }

        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        Observable<Relay>.just(relay)
            .bind(to: vc.viewModel.input.relayInfo)
            .disposed(by: disposeBag)

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToMakingRelayViewController() {
        let vc = MakingRelayRoomViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.rootView = self

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func changeRoomStyle(_ style: RelayListStyle) {
        roomView.removeFromSuperview()

        if style == .relayRoom {
            roomView = relayRoomView
        } else {
            roomView = participatedRoomView
        }
        setRoomView()
    }

    private func setRelayRoomCell(cell: RelayRoomCell, element: Relay, indexPath: IndexPath) {
        cell.profileView.nickNameLabel.text = element.title
        cell.contentLabel.text = element.notice?.notice
        cell.tagListView.tagList = element.tags ?? []

        if indexPath.row == 0 {
            cell.backgroundColor = UIColor(rgb: Color.whitePurple)
            cell.tagListView.setTags(tagViewColor: 0xFABDFF, tagTextColor: 0x5C1A62)

        } else if indexPath.row == 1 {
            cell.backgroundColor = UIColor(rgb: Color.cardBlue)
            cell.tagListView.setTags(tagViewColor: 0xB7CBFF, tagTextColor: 0x1E2F59)
        } else {
            cell.tagListView.setTags(tagViewColor: 0x4B4B4B, tagTextColor: 0xFFFFFF)
        }
    }
}

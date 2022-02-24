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

    var roomView: UIView!

    lazy var topButtonView = TopButtonView(frame: .zero, first: StringType.relayRoom, second: StringType.joinedRoom)
        .then { topView in
            topView.searchButton.isHidden = true
            topView.secondButton.snp.makeConstraints {
                $0.left.equalTo(topView.firstButton.snp.right).offset(12.0)
            }
        }

    var relayRoomView = RelayRoomView()

    lazy var participatedRoomView = ParticipatedRoomView()

    var makingRoomButton = MakingRoomButton()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
        }

    lazy var relayRoomDataSource = RxCollectionViewSectionedReloadDataSource<RelaySection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier, for: indexPath) as! RelayRoomCell

        cell.profileView.nickNameLabel.text = element.title
        cell.contentLabel.text = element.notice?.notice
        cell.tagListView.tagList = element.tags ?? []
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
            viewModel.bindRelayList()
            viewModel.bindParticipatedRoomList()
        }

        return headerView
    })

    lazy var participatedRoomDataSource = RxCollectionViewSectionedReloadDataSource<RelaySection>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelayRoomCell.relayRoomCellIdentifier, for: indexPath) as! RelayRoomCell

        cell.profileView.nickNameLabel.text = element.title
        cell.contentLabel.text = element.notice?.notice
        cell.tagListView.tagList = element.tags ?? []
        cell.tagListView.setTags()

        if indexPath.row == 0 {
            cell.backgroundColor = UIColor(rgb: Color.whitePurple)
        } else if indexPath.row == 1 {
            cell.backgroundColor = UIColor(rgb: Color.cardBlue)
        }

        return cell
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        roomView = relayRoomView
        viewModel.bindRelayList()
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

    func bindView() {
        // Input
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

        makingRoomButton.rx.tap
            .bind(to: viewModel.input.makingRoomButtonTap)
            .disposed(by: disposeBag)

        // Output
        viewModel.output.currentListStyle
            .withUnretained(self)
            .bind { owner, style in
                owner.changeRoomStyle(style: style)
            }
            .disposed(by: disposeBag)

        viewModel.output.goToBell
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToBellNoticeViewController()
            }
            .disposed(by: disposeBag)

        // relay room
        viewModel.output.relayRoomList
            .bind(to: relayRoomView.relayList.collectionView
                    .rx.items(dataSource: relayRoomDataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToDetailRelayRoom
            .withUnretained(self)
            .bind { owner, relay in
                owner.goToRelayDetailViewController(relay: relay)
            }
            .disposed(by: disposeBag)

        // participated room
        viewModel.output.participatedRoomList
            .bind(to: participatedRoomView.relayList.collectionView
                    .rx.items(dataSource: participatedRoomDataSource))
            .disposed(by: disposeBag)

        viewModel.output.goToMakingRelay
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToMakingRelayViewController()
            }
            .disposed(by: disposeBag)
    }

    private func goToBellNoticeViewController() {
        let vc = BellNoticeViewController()
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToRelayDetailViewController(relay: Relay) {
        let vc = RelayDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.relay = relay

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToMakingRelayViewController() {
        let vc = MakingRelayRoomViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.rootView = self

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func changeRoomStyle(style: RelayListStyle) {
        roomView.removeFromSuperview()

        if style == .relayRoom {
            roomView = relayRoomView
        } else {
            roomView = participatedRoomView
        }
        setRoomView()
    }
}

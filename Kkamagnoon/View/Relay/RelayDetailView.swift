//
//  RelayDetailView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class RelayDetailView: UIView {

    var disposeBag = DisposeBag()

    let backButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    let titleLabel = UILabel()
        .then {
            $0.text = StringType.relayRoom
            $0.font = UIFont.pretendard(weight: .semibold, size: 20)
            $0.textColor = .white
        }

    let bellButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    let noticeButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    var relayWritingList = ArticleListView()
        .then {
            // Dummy
            $0.collectionView.register(RelayContentCell.self, forCellWithReuseIdentifier: RelayContentCell.relayContentCellIdentifier)
            $0.collectionView.register(RelayTitleCell.self, forCellWithReuseIdentifier: RelayTitleCell.relayTitleCellIdentifier)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setBackButton()
//        setTitleLabel()
//
//        setNoticeButton()
//        setBellButton()

        setCollectionView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setBackButton() {

        self.addSubview(backButton)

        backButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().offset(26.24)
        }

        backButton.rx.tap
            .bind { _ in
                self.viewController?.navigationController?.popViewController(animated: true)

            }
            .disposed(by: disposeBag)
    }

    func setTitleLabel() {
        self.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.left.equalTo(backButton.snp.right).offset(16.88)
        }
    }

    func setNoticeButton() {
        self.addSubview(noticeButton)

        noticeButton.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.right.equalToSuperview()
            $0.centerY.equalTo(backButton)
        }
    }

    func setBellButton() {
        self.addSubview(bellButton)

        bellButton.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.right.equalTo(noticeButton.snp.left).offset(-11.0)
            $0.centerY.equalTo(backButton)
        }
    }

    func setCollectionView() {
        self.addSubview(relayWritingList)

        relayWritingList.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25.0)
            $0.width.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()

        }

        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        dummyData.bind(to: relayWritingList.collectionView
                        .rx.items) { [weak self] (_, index, _) in

            guard let self = self else { return UICollectionViewCell() }
            let indexPath = IndexPath(row: index, section: 0)
            if index == 0 {
                let cell = self.relayWritingList.collectionView.dequeueReusableCell(withReuseIdentifier: RelayTitleCell.relayTitleCellIdentifier, for: indexPath) as! RelayTitleCell
                cell.layer.cornerRadius = 15.0
                return cell
            } else {
                let cell = self.relayWritingList.collectionView.dequeueReusableCell(withReuseIdentifier: RelayContentCell.relayContentCellIdentifier, for: indexPath) as! RelayContentCell
                cell.layer.cornerRadius = 15.0
                return cell
            }

        }
        .disposed(by: disposeBag)

    }

}

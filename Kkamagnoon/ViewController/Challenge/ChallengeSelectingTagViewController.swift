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

class ChallengeSelectingTagViewController: BaseViewController {

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

        view.backgroundColor = UIColor(rgb: Color.basicBackground)

        setView()
        bindView()
    }
}

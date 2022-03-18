//
//  SearchViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewController: UIViewController {

    let viewModel = SearchViewModel()
    var disposeBag = DisposeBag()

    var searchBar = SearchBarView()
    var titleLabel = UILabel()
        .then {
            $0.text = "최근검색어"
            $0.font = UIFont.pretendard(weight: .regular, size: 14)
            $0.textColor = UIColor(rgb: 0x767676)
        }

    var tableView = UITableView()
        .then {
            $0.backgroundColor = .clear
            $0.register(SearchRecentTableViewCell.self, forCellReuseIdentifier: SearchRecentTableViewCell.identifier)
        }

    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, History>>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withIdentifier: SearchRecentTableViewCell.identifier, for: indexPath) as! SearchRecentTableViewCell

        cell.searchTextLabel.text = element.content ?? ""
        return cell
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        setView()
        bindView()

        viewModel.getRecentSearchList()
    }

}

extension SearchViewController {
    func setView() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.height.equalTo(47.0)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(33.0)
            $0.left.equalToSuperview().offset(20.0)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
        }
    }

    func bindView() {
        viewModel.output.recentSearchList
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        searchBar.searchField.rx.text
            .orEmpty
            .bind(to: viewModel.input.searchWord)
            .disposed(by: disposeBag)

        searchBar.searchButton.rx.tap
            .bind(to: viewModel.input.searchButtonTap)
            .disposed(by: disposeBag)

        searchBar.backButton.rx.tap
            .bind(to: viewModel.input.backButtonTap)
            .disposed(by: disposeBag)
    }
}

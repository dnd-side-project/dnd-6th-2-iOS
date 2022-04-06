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

    var searchContentView: UIView!

    var searchHistoryView = SearchHistoryView()
    var searchResultView = SearchResultView()
        .then {
            $0.menuTabView.menuCollectionView.register(SearchTabMenuCell.self, forCellWithReuseIdentifier: SearchTabMenuCell.identifier)
            $0.searchResultListView.collectionView.register(MyWritingCell.self, forCellWithReuseIdentifier: MyWritingCell.identifier)

        }

    lazy var historyDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, History>>(configureCell: { _, tableView, indexPath, element in

        let cell = tableView.dequeueReusableCell(withIdentifier: SearchRecentTableViewCell.identifier, for: indexPath) as! SearchRecentTableViewCell

        cell.searchTextLabel.text = element.content ?? ""
        return cell
    })

    lazy var searchResultDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Article>>(configureCell: { _, collectionView, indexPath, element in

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWritingCell.identifier, for: indexPath) as! MyWritingCell

        cell.titleLabel.text = element.title ?? ""
        cell.contentLabel.text = element.content ?? ""
        cell.likeLabel.labelView.text = String(element.likeNum ?? 0)
        cell.commentLabel.labelView.text = String(element.commentNum ?? 0)

        return cell
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        searchContentView = searchHistoryView
        view.backgroundColor = UIColor(rgb: Color.basicBackground)

        setSearchBar()
        setSearchContentView()
        bindView()

        viewModel.getRecentSearchList()
    }

}

extension SearchViewController {
    func setSearchBar() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.height.equalTo(47.0)
        }
    }

    func setSearchContentView() {
        view.addSubview(searchContentView)
        searchContentView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
        }
    }

    func changeSearchContentStyle(style: SearchContentStyle) {
        searchContentView.removeFromSuperview()

        if style == .history {
            searchContentView = searchHistoryView
        } else {
            searchContentView = searchResultView
        }

        setSearchContentView()
    }

    func bindView() {

        // input
        Observable.of(["챌린지", "자유글", "릴레이"])
            .bind(to: searchResultView.menuTabView.menuCollectionView.rx.items(cellIdentifier: SearchTabMenuCell.identifier,
                                         cellType: SearchTabMenuCell.self)) { (_, element, cell) in
                cell.textLabel.text = element
                }
            .disposed(by: disposeBag)

        searchResultView.menuTabView.menuCollectionView
            .rx.itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                let index = indexPath.row
                owner.searchResultView.menuTabView.indicatorViewLeftContraint.constant = CGFloat(index)*((UIScreen.main.bounds.width - 40)/3)
            }
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

        // output
        viewModel.output.recentSearchList
            .bind(to: searchHistoryView.tableView.rx.items(dataSource: historyDataSource))
            .disposed(by: disposeBag)

        viewModel.output.searchResultList
            .bind(to: searchResultView.searchResultListView.collectionView.rx.items(dataSource: searchResultDataSource))
            .disposed(by: disposeBag)

        viewModel.output.searchContentStyle
            .withUnretained(self)
            .bind { owner, style in
                owner.changeSearchContentStyle(style: style)
            }
            .disposed(by: disposeBag)

        viewModel.output.dismissView
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismissView()
            }
            .disposed(by: disposeBag)
    }

    private func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
}

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

        setLayout()
        bindInput()
        bindOutput()

        viewModel.getRecentSearchList()

    }

}

extension SearchViewController {
    func setLayout() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.height.equalTo(47.0)
        }

        setSearchContentView()
    }

    func setSearchContentView() {
        view.addSubview(searchContentView)
        searchContentView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
        }
    }

    func changeSearchContentStyle(_ style: SearchContentStyle) {
        searchContentView.removeFromSuperview()

        if style == .history {
            searchContentView = searchHistoryView
        } else {
            searchContentView = searchResultView
        }

        setSearchContentView()
    }
}

extension SearchViewController {
    func bindInput() {

        searchBar.searchField.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .bind(to: viewModel.input.searchWord)
            .disposed(by: disposeBag)

        searchBar.searchButton.rx.tap
            .bind(to: viewModel.input.searchButtonTap)
            .disposed(by: disposeBag)

        searchBar.backButton.rx.tap
            .bind(to: viewModel.input.backButtonTap)
            .disposed(by: disposeBag)

        searchHistoryView.tableView
            .rx.modelSelected(History.self)
            .bind(to: viewModel.input.historyWordTap)
            .disposed(by: disposeBag)

        searchResultView.menuTabView.menuCollectionView
            .rx.itemSelected
            .bind(to: viewModel.input.menuTapAtIndex)
            .disposed(by: disposeBag)
    }

    func bindOutput() {

        viewModel.output.menuList
            .bind(to: searchResultView.menuTabView.menuCollectionView.rx
                    .items(cellIdentifier: SearchTabMenuCell.identifier,
                           cellType: SearchTabMenuCell.self)
                    ) { (_, element, cell) in
                        cell.textLabel.text = element
                    }
            .disposed(by: disposeBag)

        viewModel.output.recentSearchList
            .asDriver()
            .drive(searchHistoryView.tableView.rx.items(dataSource: historyDataSource))
            .disposed(by: disposeBag)

        viewModel.output.searchResultList
            .asDriver()
            .drive(searchResultView.searchResultListView
                    .collectionView.rx.items(dataSource: searchResultDataSource))
            .disposed(by: disposeBag)

        viewModel.output.searchContentStyle
            .asDriver()
            .drive(onNext: changeSearchContentStyle)
            .disposed(by: disposeBag)

        viewModel.output.dismissView
            .asSignal()
            .emit(onNext: dismissView)
            .disposed(by: disposeBag)

        viewModel.input.searchWord
            .asDriver()
            .drive(onNext: setSearchBarText)
            .disposed(by: disposeBag)

        viewModel.output.moveIndicatorBar
            .asSignal()
            .emit(onNext: moveIndicatorBar)
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    private func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }

    private func moveIndicatorBar(_ indexPath: IndexPath) {
        let index = indexPath.row
        searchResultView.menuTabView.indicatorViewLeftContraint.constant = CGFloat(index)*((UIScreen.main.bounds.width - 40)/3)
    }

    private func setSearchBarText(_ word: String) {
        searchBar.searchField.text = word
    }
}

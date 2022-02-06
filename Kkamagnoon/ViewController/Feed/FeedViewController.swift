//
//  FeedViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit
import RxSwift
import RxCocoa

class FeedViewController: UIViewController {

    let wholeFeedButton: UIButton = UIButton()
    let subscribeFeedButton: UIButton = UIButton()

    let searchButton: UIButton = UIButton()
    let bellButton: UIButton = UIButton()

    var filterView: UICollectionView!
    
    let sortButton: UIButton = UIButton()
    var feedCollectionView: UICollectionView!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindFeedButton()
        bindExtraButton()
        bindFilterView()
        bindSortButton()
        bindFeedCollectionView()
    }

    func bindFeedButton() {
        wholeFeedButton.setTitle(StringType.wholeFeed, for: .normal)
        wholeFeedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        wholeFeedButton.sizeToFit()
        view.addSubview(wholeFeedButton)

        wholeFeedButton.translatesAutoresizingMaskIntoConstraints = false

        wholeFeedButton.topAnchor
            .constraint(equalTo: view.topAnchor,
                        constant: 63).isActive = true
        wholeFeedButton.leftAnchor
            .constraint(equalTo: view.leftAnchor,
                        constant: 20).isActive = true

        subscribeFeedButton.setTitle(StringType.subscribeFeed, for: .normal)
        subscribeFeedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        subscribeFeedButton.sizeToFit()
        view.addSubview(subscribeFeedButton)

        subscribeFeedButton.translatesAutoresizingMaskIntoConstraints = false

        subscribeFeedButton.topAnchor
            .constraint(equalTo: view.topAnchor,
                        constant: 63).isActive = true
        subscribeFeedButton.leftAnchor
            .constraint(equalTo: view.leftAnchor,
                        constant: 111).isActive = true
    }

    func bindExtraButton() {

        bellButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.addSubview(bellButton)

        bellButton.translatesAutoresizingMaskIntoConstraints = false
        bellButton.rightAnchor
            .constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        bellButton.topAnchor
            .constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        bellButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        bellButton.heightAnchor.constraint(equalToConstant: 28).isActive = true

        searchButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)

        view.addSubview(searchButton)

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.rightAnchor
            .constraint(equalTo: bellButton.leftAnchor, constant: -8).isActive = true
        searchButton.topAnchor
            .constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 28).isActive = true

    }

    func bindFilterView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 6

        filterView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filterView.register(CategoryFilterCell.self, forCellWithReuseIdentifier: CellIdentifier.categoryFilter)
        filterView.showsHorizontalScrollIndicator = false

        let width = filterView.frame.width
        flowLayout.estimatedItemSize = CGSize(width: width, height: 29)

        filterView.collectionViewLayout = flowLayout
        view.addSubview(filterView)

        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        filterView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        filterView.topAnchor.constraint(equalTo: wholeFeedButton.bottomAnchor, constant: 19).isActive = true
        filterView.heightAnchor.constraint(equalToConstant: 29).isActive = true

        let testData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        testData
            .bind(to: filterView.rx
                        .items(cellIdentifier: CellIdentifier.categoryFilter,
                               cellType: CategoryFilterCell.self)) { (_, element, cell) in
                cell.backgroundColor = .blue
                cell.layer.cornerRadius = 18
                cell.categoryLabel.text = element
        }
        .disposed(by: disposeBag)
    }

    func bindSortButton() {
        sortButton.setTitle("인기순", for: .normal)
        sortButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        sortButton.sizeToFit()
        sortButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        view.addSubview(sortButton)

        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 20).isActive = true
        sortButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -27).isActive = true
    }

    func bindFeedCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        feedCollectionView.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 20,
                                          height: feedCollectionView.frame.height)
        feedCollectionView.collectionViewLayout = layout
        view.addSubview(feedCollectionView)

        feedCollectionView.translatesAutoresizingMaskIntoConstraints = false

        feedCollectionView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 11.83).isActive = true
        feedCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        feedCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        feedCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        let dummyData = Observable<[String]>.of(["글감", "일상", "로맨스", "짧은 글", "긴 글", "무서운 글", "발랄한 글", "한글", "세종대왕"])

        dummyData.bind(to: feedCollectionView.rx.items(cellIdentifier: "FeedCell",
                                                       cellType: FeedCell.self)) { (_, element, cell) in
            cell.backgroundColor = .blue
                cell.articleTitle.text = element
            }
        .disposed(by: disposeBag)

    }
}

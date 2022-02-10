//
//  NewFeedViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

class FeedViewController: UIViewController {

    let disposeBag = DisposeBag()

    lazy var wholeFeedButton = UIButton()
    lazy var subscribeButton = UIButton()

    lazy var searchButton: UIButton = UIButton()
    lazy var bellButton: UIButton = UIButton()

    var tabCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        bindChooseFeedButton()
        bindBellButton()
        bindSearchButton()
        bindTabCollectionView()
    }

    func bindChooseFeedButton() {
        wholeFeedButton.setTitle(StringType.wholeFeed, for: .normal)
        wholeFeedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.addSubview(wholeFeedButton)
        wholeFeedButton.translatesAutoresizingMaskIntoConstraints = false
        wholeFeedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
        wholeFeedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true

        subscribeButton.setTitle(StringType.subscribeFeed, for: .normal)
        subscribeButton.setTitleColor(UIColor.gray, for: .normal)
        subscribeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.addSubview(subscribeButton)
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        subscribeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
        subscribeButton.leftAnchor.constraint(equalTo: wholeFeedButton.rightAnchor, constant: 10).isActive = true

        let tabButtons = [wholeFeedButton, subscribeButton]

        for idx in 0 ..< tabButtons.count {
            tabButtons[idx].rx.tap
                .bind { _ in
                    if idx == 1 {
                        self.searchButton.isHidden = true
                    } else {
                        self.searchButton.isHidden = false
                    }
                    tabButtons[idx].titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                    tabButtons[idx].setTitleColor(.white, for: .normal)

                    tabButtons[1-idx].titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
                    tabButtons[1-idx].setTitleColor(.gray, for: .normal)

                    self.tabCollectionView
                        .scrollToItem(at: IndexPath(item: idx, section: 0),
                                      at: .centeredHorizontally,
                                      animated: false)
                }
                .disposed(by: disposeBag)
        }
    }

    func bindBellButton() {
        bellButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.addSubview(bellButton)
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        bellButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        bellButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        bellButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        bellButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
    }

    func bindSearchButton() {

        searchButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        searchButton.rightAnchor.constraint(equalTo: bellButton.leftAnchor, constant: -8).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }

    func bindTabCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize.width = view.frame.width
        layout.itemSize.height = view.frame.height

//        print ("HEIGHT: \(view.frame.height) ")

        tabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabCollectionView.register(WholeTabCell.self, forCellWithReuseIdentifier: CellIdentifier.wholeTab)
        tabCollectionView.register(SubscribeTabCell.self, forCellWithReuseIdentifier: CellIdentifier.subscribeTab)

        tabCollectionView.showsHorizontalScrollIndicator = false

        tabCollectionView.isPagingEnabled = false
        tabCollectionView.isScrollEnabled = false
        tabCollectionView.backgroundColor = .none
        tabCollectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tabCollectionView)

        tabCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tabCollectionView.topAnchor.constraint(equalTo: wholeFeedButton.bottomAnchor).isActive = true
        tabCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        Observable<[String]>.of(["1", "2"])
            .bind(to: tabCollectionView.rx.items) { (collectionView, row, _) in
                let indexPath = IndexPath(row: row, section: 0)
                var cell: UICollectionViewCell
                if indexPath.item == 0 {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.wholeTab, for: indexPath)
                } else {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.subscribeTab, for: indexPath)
                }
                return cell
            }
            .disposed(by: disposeBag)
    }

}
